#!/bin/bash

# Function to compile the programs using make
compile() {
    echo "Compiling the programs..."
    make clean
    make
}

# Function to execute aes or masked_aes
run_program() {
    if [ "$1" == 1 ]; then
        echo "Running the original AES..."
        ./aes
    elif [ "$1" == 2 ]; then
        echo "Running the masked AES..."
        
        # Ask if the user wants robust or lightweight mask generation
        read -p "Do you want the masks to be generated robustly or lightly? (Enter 'robust' or 'light'): " choice
        
        if [ "$choice" == "robust" ]; then
            echo "Running masked AES with robust mask generation..."
            ./aes_masked 1
        elif [ "$choice" == "light" ]; then
            echo "Running masked AES with lightweight mask generation..."
            ./aes_masked 0
        else
            echo "Invalid choice. Exiting."
            exit 1
        fi
    else
        echo "Invalid program choice. Exiting."
        exit 1
    fi
}

# Main script
echo "Welcome! Please choose an option:"
echo "1. Execute original AES (aes)"
echo "2. Execute masked AES (masked_aes)"

# Get user choice for program
read -p "Enter your choice (aes/masked_aes): " program_choice

# Compile the programs
compile

# Run the chosen program
run_program $program_choice
