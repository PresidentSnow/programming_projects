#!/bin/bash

echo " "
echo "Welcome to the simple calculator!"
echo "Let's start."
echo " "

# regex for check if the input number if a number
EXPR='^-?[0-9]+$'

read -p "Enter the first num (A): " Anum
echo " "
read -p "Enter the secon num (B): " Bnum
echo " "

# Check if A and B is number
if ! [[ "$Anum" =~ $EXPR ]] || ! [[ "$Bnum" =~ $EXPR ]]; then
  echo "ERROR: The input IS NOT a number."
  exit 1
fi

# Input type of operation
echo "Enter the choice: "
echo "1. Addition." # sum
echo "2. Subtraction." # less
echo "3. Multiplication."
echo "4. Division."
echo " "
read type
echo " "

# Switch Case to perform
# Calculator operations
case $type in
  1)res=`echo $Anum + $Bnum | bc`
  ;;
  2)res=`echo $Anum - $Bnum | bc`
  ;;
  3)res=`echo $Anum \* $Bnum | bc`
  ;;
  4)res=`echo "scale=2; $Anum / $Bnum" | bc`
  ;;
  *) echo "Invalid choice. Exiting."
  exit 1
  ;;
esac

# Print the result
echo "Result: $res"
