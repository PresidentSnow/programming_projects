#!/bin/bash

# Script for check the internet connection
# status using the nmcli command

state=$(nmcli g status | awk 'NR==2 {print $1}')

echo " "
if [[ $state == "disconnected" ]]; then
  echo "Network connection is NOT available."
else
  echo "Network connection IS available."
fi
echo " "
