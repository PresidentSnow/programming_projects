#!/bin/bash

# An Armstrong number is a number that is
# the sum of its own digits each raised to
# the power of the number of digits.

# For example:
# 9 is an Armstrong number, because 9 = 9^1 = 9
# 10 is not an Armstrong number,
# because 10 != 1^2 + 0^2 = 1

echo " "
echo "Welcome to the Armstrong number!!"
echo "Let's start!!"
echo " "

# Regex for check the number
REGEX_NUM='^[0-9]+$'

read -p "Please, enter a random number: " num
echo " "

if [[ ! "$num" =~ $REGEX_NUM ]]; then
  echo "ERROR: Please, enter just numbers."
  echo " "
  exit 1
fi

# Function to determine if the
# number is an Armstrong number.
arm_num(){
  local input="$1"
  local length=${#input} # This extracts the single characters

  # This accumulate the total of each digit raised to the
  # power of the number of digits in the input number.
  local sum=0

  # Calculate the sum of each digit raised
  # to the power of the number of digits.
  for ((i = 0; i < length; i++)); do
    local digit="${input:i:1}" # Extract a single character

    # Raise the digit to the power of the number of digits
    local power=$((digit ** length))
    sum=$((sum + power)) # Add to the sum
  done

  # Check if the sum is equal to the original number
  if [[ $sum -eq $input ]]; then
    echo "$input is an Armstrong number."
  else
    echo "$input is not an Armstrong number."
  fi
  echo " "
}

# Call the function
arm_num "$num"
