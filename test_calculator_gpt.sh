#!/bin/bash

# Define the test file name
TEST_FILE="calculator-gpt-tests.txt"

# Initialize counters for total tests and passed tests
TOTAL_TESTS=0
PASSED_TESTS=0

# Read the test file line by line
while read -r line; do
    # Increment the total tests counter
    ((TOTAL_TESTS++))

    # Run the calculator-gpt.py with the current equation
    GPT_RESULT=$(python calculator-gpt.py "$line")

    # Perform the same calculation using Bash and store the result
    BASH_RESULT=$(echo "$line" | bc)

    # Check if calculator-gpt.py output is "The answer to life, the universe, and everything"
    if [ "$GPT_RESULT" == "The answer to life, the universe, and everything" ]; then
        GPT_RESULT=42
    fi

    # Round the GPT_RESULT if it's a floating-point number
    if [[ "$GPT_RESULT" =~ ^[0-9]*\.[0-9]*$ ]]; then
        GPT_RESULT=$(echo "($GPT_RESULT+0.5)/1" | bc)
    fi

    # Compare the results of calculator-gpt.py and Bash
    if [ "$GPT_RESULT" == "$BASH_RESULT" ]; then
        # Increment the passed tests counter if the results match
        ((PASSED_TESTS++))
    else
        # Print the mismatched results for debugging
        echo "Mismatch: calculator-gpt.py = $GPT_RESULT, Bash = $BASH_RESULT (Equation: $line)"
    fi
done < "$TEST_FILE"

# Calculate the success rate and print the results
SUCCESS_RATE=$(echo "scale=2; ($PASSED_TESTS / $TOTAL_TESTS) * 100" | bc)
echo "calculator-gpt passed tests: $PASSED_TESTS / $TOTAL_TESTS (Success rate: $SUCCESS_RATE%)"
