#!/bin/bash

# Function to convert PNG files to different sizes
png2size() {
  # List all PNG files in the current directory
  echo "Listing all PNG files in the current directory:"
  png_files=(*.png)
  if [ ${#png_files[@]} -eq 0 ]; then
    echo "No PNG files found."
    exit 1
  else
    for i in "${!png_files[@]}"; do
      echo "$((i+1)). ${png_files[$i]}"
    done
  fi

  # Ask for the file to convert
  read -p "Enter the number of the file you want to convert: " file_choice
  selected_file=${png_files[$((file_choice-1))]}

  # Ask for the size to convert to
  echo "Available sizes:"
  echo "1. 64x64"
  echo "2. 128x128"
  echo "3. 512x512"
  read -p "Enter the size you want to convert to (1/2/3): " size_choice

  case $size_choice in
    1) size="64x64" ;;
    2) size="128x128" ;;
    3) size="512x512" ;;
    *) echo "Invalid choice"; exit 1 ;;
  esac

  # Now perform the conversion
  # Check if the file exists
  if [ ! -f "$selected_file" ]; then
    echo "File not found: $selected_file"
    exit 1
  fi

  # Perform the conversion using ImageMagick's convert command
  output_file="${selected_file%.png}_$size.png"
  convert "$selected_file" -resize "$size" "$output_file"

  echo "Converted $selected_file to $output_file"
}

