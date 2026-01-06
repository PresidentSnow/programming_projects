#!/bin/bash

# Regular expression for phone number validation
regex="^(\+?[0-9]{1,3}[-.\s]?)?(\(?[0-9]{3}\)?[-.\s]?)?[0-9]{3}[-.\s]?[0-9]{4}$"

# Test cases
phone_numbers=(
    "+1 (555) 123-4567"
    "555-123-4567"
    "+44 20 7946 0958"
    "+91-9876543210"
    "123 456 7890"
    "(123) 456-7890"
    "123.456.7890"
    "+49 30 123456"
    "5551234567"
    "1-800-123-4567"
    "18001234567"
    "123-45-6789"   # Invalid case (too short)
    "123-456-78901" # Invalid case (too long)
)

# Function to test the regex against each phone number
function test_phone_number {
    local phone_number=$1
    if [[ $phone_number =~ $regex ]]; then
        echo "$phone_number - Match"
    else
        echo "$phone_number - No Match"
