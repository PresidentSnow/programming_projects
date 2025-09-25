#!/bin/bash

# Program to reverse string

echo " "
echo "Welcome to this program!!"
echo "We'll now reverse a string."
echo " "

# Regex for check if the input is a reall string
REGEX_STRING='^[a-zA-Z]+$'

read -p "Enter a string, please: " letter
echo " "

if [[ ! "$letter" =~ $REGEX_STRING ]]; then
  echo "Sorry, just letters please."
  exit 1
fi

# Usng rev command
rev_command(){
  local reversed=$( echo "$letter" | rev)

  # Other option
  local invest=$( rev <<< "$letter")
  # <<<: It allows you to pass a string directly
  # to the standard input of a command.

  echo "$reversed" # Output the result
}

# Using loops for reverse a string
rev_loop(){
  local input="$1"
  local des=''

  # ${#input}: This gives the length of the string
  for ((i = 0; i < ${#input}; i++)); do

    # ${input:i:1}$des: This line constructs the reversed string.

    # ${input:i:1}: Extracts a single character from input at position
    # i. The extracted character is prepended to des. This means that
    # the last character of input will be the first character of des,
    # effectively reversing the string.

    des="${input:i:1}$des"
  done
  echo "$des" # Output the reversed string
}

# Call the function with user input
result=$(rev_command) # Call -rev_command- function
#result=$(rev_loop "$letter") # Call -rev_loop- function
echo "Reversed string: $result"

