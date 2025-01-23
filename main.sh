#!/bin/bash

# Source the png2size.sh script
source ./scripts/png2size.sh

# List of scripts
scripts=("png2size" "ico2png" "script3" "script4" "script5" "script6" "script7" "script8" "script9" "script10" "script11" "script12" "script13" "script14")

# Function to display scripts with pagination
display_scripts() {
  local start=$1
  local end=$2
  local script_choice
  
  # Display scripts from start to end
  echo "Listing scripts from $start to $end:"
  for i in $(seq $start $end); do
    if [ $i -le ${#scripts[@]} ]; then
      echo "$i. ${scripts[$i-1]}"
    fi
  done

  # Prompt for user input
  read -p "Enter the number of the script you want to run (or 'n' for next page, 'p' for previous page, 'q' to quit): " script_choice

  case $script_choice in
    [1-9]|1[0-2]) # Valid range for script selection
      echo "You selected ${scripts[$script_choice-1]}"
      if [ "$script_choice" -eq 1 ]; then
        # Call the png2size function from png2size.sh
        png2size
      fi
      ;;
    n)
      next_page $end
      ;;
    p)
      prev_page $start
      ;;
    q)
      echo "Exiting..."
      exit 0
      ;;
    *)
      echo "Invalid option. Please try again."
      display_scripts $start $end
      ;;
  esac
}

# Function to handle "next page" functionality
next_page() {
  local current_end=$1
  local new_start=$((current_end + 1))
  local new_end=$((current_end + 10))

  # Check if there are more scripts
  if [ $new_start -le ${#scripts[@]} ]; then
    display_scripts $new_start $new_end
  else
    # Display remaining scripts
    display_scripts $new_start ${#scripts[@]}
  fi
}

# Function to handle "previous page" functionality
prev_page() {
  local current_start=$1
  local new_start=$((current_start - 10))
  local new_end=$((current_start - 1))

  if [ $new_start -ge 1 ]; then
    display_scripts $new_start $new_end
  else
    # If at the start, show the first page
    display_scripts 1 10
  fi
}

# Loop to keep the script running
while true; do
  # Initial page load (1st to 10th scripts)
  display_scripts 1 10
done
