#!/bin/bash

# Function to check if a file is a PDF
is_pdf() {
    file="$1"
    mime_type=$(file --mime-type -b "$file")
    if [ "$mime_type" = "application/pdf" ]; then
        return 0
    else
        return 1
    fi
}

# Function to run pdfbook2 if the file is a PDF
process_pdf() {
    file="$1"
    if is_pdf "$file"; then
        echo "Processing PDF: $file"
        pdfbook2 "$file"
    else
        echo "Skipping non-PDF file: $file"
    fi
}

# Function to pass directory to pdfifier.sh
pass_directory_to_pdfifier() {
    directory="$1"
    echo "Running pdfifier.sh for directory: $directory"
    bash pdfifier.sh "$directory" "$2"
}

# Main function to process directories
main() {
    if [ "$1" = "test" ]; then
        shift
        for directory in "$@"; do
            pass_directory_to_pdfifier "$directory" "test"
        done
    else
        for directory in "$@"; do
            pass_directory_to_pdfifier "$directory"
        done
    fi
}

# Process each file in the specified directories
for dir in "$@"; do
    for file in "$dir"/*; do
        process_pdf "$file"
    done
done

# Execute main function with passed arguments
main "$@"

