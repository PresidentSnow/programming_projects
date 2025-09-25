#!/bin/bash

# Script to assemble and execute the assembly code.


# Define paths for the source, object, and binary files.
SRC="../src_simple_exercises/test_add.asm"
OBJ="../object_simple_exercises/test_add.o"
BIN="../bin_simple_exercises/test_add"

# This is for debugg the test code using GDB.

# Assemble the assembly code to create object file.
nasm -f elf64 "$SRC" -g -F dwarf -o "$OBJ"

# Link the object file to create an executable.
ld "$OBJ" -o "$BIN"

# Execute the compiled program.
gdb "$BIN"
