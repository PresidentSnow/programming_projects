#!/bin/bash

# List of passwords to test
passwords=(
    "Password123!"       # Valid
    "pass123!"           # Invalid (no uppercase)
    "PASSWORD123!"       # Invalid (no lowercase)
    "Password!"          # Invalid (no number)
    "Password123"        # Invalid (no special character)
    "P@ssw0rd"           # Valid
    "StrongP@ssw0rd"     # Valid
    "WeakPassword123"    # Invalid (no special character)
    "1234!@#$"           # Invalid (no letters)
    "Valid123@Pass"      # Valid
    "Pas1#"              # InValid (length less than 8)
)

# Regular expression for password validation
regex='^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[@$!%*?&]).{8,}$'

# Function to validate passwords using grep -P
validate_password() {
    local password=$1

    # Debugging output to check the password being tested
    echo "Testing password: '$password'"

    if echo "$password" | grep -P "$regex" >/dev/null; then
        echo "Password '$password' is VALID."
      else
        echo "Password '$password' is INVALID."
    fi
}

# Loop through each password and validate it
for password in "${passwords[@]}"; do
    validate_password "$password"
done
