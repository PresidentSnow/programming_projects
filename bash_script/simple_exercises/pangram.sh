#!/bin/bash

# Exercise for check if a sentence
# is a pangram or not.

# A pangram is a sentence using every
# letter of the alphabet at least once.

#!/usr/bin/env bash

echo " "
echo "Start pangram program."
echo " "

main() {
  read -p "Enter the sentence: " phrase
  sentence=${phrase^^}
  for letter in {A..Z}; do
    if [[ ! $sentence =~ $letter ]]; then
      echo "The sentence is NOT a pangram."
      exit 1
    fi
  done
  echo "The sentence IS a pangram."
}

main "$@"
echo " "
