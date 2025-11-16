#!/bin/zsh

# script for automate c++

# Clean the first data information
clear

# Define paths for the source, object, and binary files.
SRC="../src_vigenere_method/geek_vigenere.cpp" # source code
BIN="../bin_vigenere_method/geek_vigenere" # executable
SCRIPT="../script_vigenere_method/geek_vigenere.sh" # script file

g++ "$SRC" -o "$BIN"

# this is executable
"$BIN"

# changes the permissions of the executable and script files
chmod 750 "$BIN"
chmod 750 "$SCRIPT"