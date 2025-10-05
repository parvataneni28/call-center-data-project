#!/bin/bash

API_URL="https://xfrxjeeu86.execute-api.us-east-1.amazonaws.com/prod/chat"
OUTPUT_FILE="test_results_$(date +%Y%m%d_%H%M%S).txt"

echo "Testing all chatbot questions - $(date)" > $OUTPUT_FILE
echo "=========================================" >> $OUTPUT_FILE

questions=(
    "Who handled the most calls?"
    "Show me the top 5 agents by call count"
    "What are the most frequent call topics?"
    "Show me agent call volumes"
    "What are the top call categories?"
    "Who are the best performing agents?"
    "Show me call topic distribution"
    "Give me agent rankings"
    "What are the popular call topics?"
    "Show me agent call metrics"
    "What are the top 10 call topics?"
    "Show me agent performance ranking"
    "Who are the call volume leaders?"
    "Show me the most active agents"
    "Give me call category breakdown"
)

for i in "${!questions[@]}"; do
    test_num=$((i + 21))
    question="${questions[$i]}"
    
    echo "" >> $OUTPUT_FILE
    echo "Test $test_num: $question" >> $OUTPUT_FILE
    echo "----------------------------------------" >> $OUTPUT_FILE
    
    response=$(curl -s -X POST "$API_URL" \
        -H "Content-Type: application/json" \
        -d "{\"question\": \"$question\"}")
    
    if echo "$response" | grep -q '"error"'; then
        echo "FAILED - $(echo "$response" | jq -r '.error')" >> $OUTPUT_FILE
    else
        echo "SUCCESS" >> $OUTPUT_FILE
        echo "SQL: $(echo "$response" | jq -r '.sql')" >> $OUTPUT_FILE
        echo "Results: $(echo "$response" | jq -r '.results.Rows | length') rows returned" >> $OUTPUT_FILE
    fi
done

echo "" >> $OUTPUT_FILE
echo "Testing completed at $(date)" >> $OUTPUT_FILE
echo "Results saved to: $OUTPUT_FILE"
