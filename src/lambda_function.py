import json
import boto3
import re

def lambda_handler(event, context):
    try:
        body = json.loads(event['body'])
        question = body['question']
        
        bedrock = boto3.client('bedrock-runtime', region_name='us-east-1')
        athena = boto3.client('athena', region_name='us-east-1')
        
        schema_context = """
Table: call_metadata_external
Columns: call_id (string), call_start_timestamp (timestamp), call_end_timestamp (timestamp), 
agent_id (string), agent_name (string), customer_phone (string), call_topic (string), 
call_end_result (string - descriptive text like 'Transferred to commercial department', NOT 'Successful'), 
call_sentiment_overall (string), customer_name (string), ingestion_timestamp (timestamp)
Partitions: year (string), month (string), day (string)
Database: call_data_db

IMPORTANT: call_end_result contains descriptive outcomes, not simple success/failure values.
"""
        
        prompt = f"""You are a SQL expert. Generate ONLY valid Athena SQL for this question. 
DO NOT include any explanatory text, comments, or formatting. 
Return ONLY the SQL query that can be executed directly.
Always use the full table reference: call_data_db.call_metadata_external
Do NOT use date comparisons with timestamps unless explicitly needed.
Do NOT use INTERVAL data types - use simple date functions instead.
Partition columns (year, month, day) are strings and need quotes when filtering.

CRITICAL: For questions about "popular" or "most frequent" topics, do NOT add WHERE filters unless the question specifically asks to filter by something. Just GROUP BY and ORDER BY COUNT(*) DESC.

{schema_context}

Question: {question}

SQL:"""
        
        response = bedrock.invoke_model(
            modelId='amazon.nova-pro-v1:0',
            body=json.dumps({
                'messages': [{'role': 'user', 'content': [{'text': prompt}]}],
                'inferenceConfig': {
                    'max_new_tokens': 512,
                    'temperature': 0.1
                }
            })
        )
        
        result = json.loads(response['body'].read())
        sql_query = result['output']['message']['content'][0]['text'].strip()
        
        # Clean the response - remove markdown and any non-SQL text
        sql_query = re.sub(r'^```sql\s*', '', sql_query, flags=re.MULTILINE)
        sql_query = re.sub(r'\s*```$', '', sql_query, flags=re.MULTILINE)
        sql_query = re.sub(r'^.*?SELECT', 'SELECT', sql_query, flags=re.DOTALL | re.IGNORECASE)
        sql_query = re.sub(r';.*$', ';', sql_query, flags=re.DOTALL)
        
        # Fix common issues
        sql_query = sql_query.replace('awsdatacatalog.default.call_metadata_external', 'call_data_db.call_metadata_external')
        sql_query = re.sub(r'INTERVAL\s+\'\d+\'\s+DAY', 'DATE_SUB(CURRENT_DATE, 30)', sql_query, flags=re.IGNORECASE)
        
        if not sql_query.endswith(';'):
            sql_query += ';'
        
        # Execute query
        query_response = athena.start_query_execution(
            QueryString=sql_query,
            QueryExecutionContext={
                'Database': 'call_data_db'
            },
            ResultConfiguration={
                'OutputLocation': 's3://athena-query-results-chatbot-262918648468/'
            },
            WorkGroup='primary'
        )
        
        execution_id = query_response['QueryExecutionId']
        
        # Wait for completion
        import time
        while True:
            status = athena.get_query_execution(QueryExecutionId=execution_id)
            state = status['QueryExecution']['Status']['State']
            if state in ['SUCCEEDED', 'FAILED', 'CANCELLED']:
                break
            time.sleep(1)
        
        if state == 'SUCCEEDED':
            results = athena.get_query_results(QueryExecutionId=execution_id)
            return {
                'statusCode': 200,
                'headers': {'Content-Type': 'application/json'},
                'body': json.dumps({
                    'sql': sql_query,
                    'results': results['ResultSet']
                })
            }
        else:
            error_reason = status['QueryExecution']['Status'].get('StateChangeReason', 'Unknown error')
            return {
                'statusCode': 500,
                'headers': {'Content-Type': 'application/json'},
                'body': json.dumps({'error': f'Query failed: {error_reason}'})
            }
            
    except Exception as e:
        return {
            'statusCode': 500,
            'headers': {'Content-Type': 'application/json'},
            'body': json.dumps({'error': str(e)})
        }
