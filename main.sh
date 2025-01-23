#!/bin/bash

# Source the png2size.sh script
source ./scripts/png2size.sh

# Main menu for selecting the operation
echo "What will you do now?"
echo "List of scripts:"
echo "1. png2size"
echo "2. ico2png"
echo "3. ..."

# Prompt for user input
read -p "Enter the number of the script you want to run: " script_choice

case $script_choice in
  1)
    # Call the png2size function from png2size.sh
    png2size
    ;;
  2)
    # For ico2png (future implementation)
    echo "You selected ico2png (not implemented yet)"
    ;;
  *)
    echo "Invalid option"
    ;;
esac

