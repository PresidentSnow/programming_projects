#!/bin/bash

# Script to assemble and execute the assembly code.

# Define paths for the source, object, and binary files.
SRC="../src_simple_exercises/hello.asm"
OBJ="../object_simple_exercises/hello.o"
BIN="../bin_simple_exercises/hello"

# Assemble the assembly code to create object file.
nasm -f elf64 "$SRC" -o "$OBJ"

# Link the object file to create an executable.
ld "$OBJ" -o "$BIN"

# Execute the compiled program.
"$BIN"

# Maintain the original file permissions.
sudo chmod 750 "$BIN"