#!/bin/bash

# Get the name of the words file
words_file=$1
num_files=$2

# Check if the words file exists
if [ ! -f $words_file ]; then
  echo "File $words_file does not exist."
  exit 1
fi

# Get the number of lines in the words file
num_lines=$(wc -l < $words_file)

# Calculate the number of lines in each section of the file
lines_per_file=$((num_lines / num_files))

# Create two new files to store the split words
split_file_name_prefix=$words_file.split

# Split word files into multiple files
for i in $(seq 1 $num_files); do
  # The name of this split file
  split_file_name=$split_file_name_prefix.$i
  
  # The temporary starting point with the offset of this file
  temp_start=$((num_lines - $(($((i-1)) * lines_per_file ))))

  # Split the words file into the current split file
  tail -n $temp_start $words_file | head -n $lines_per_file > $split_file_name
done

# Print a message to the user
echo "Words file $words_file has been split into $num_files files:"
for i in $(seq 1 $num_files); do
  echo "  * $split_file_name_prefix.$i"
done
