#!/bin/bash

list_file_types_with_example() {
    find "$1" -type f | while read file; do
        extension="${file##*.}"
        echo "$extension"
    done | sort | uniq -c | while read count extension; do
        example_file=$(find "$1" -type f -name "*.$extension" | head -n 1)
        echo "File type: $extension | Count: $count | Example file: $example_file"
    done
}

main() {
    directory="$1"
    if [ ! -d "$directory" ]; then
        echo "Directory does not exist!"
        exit 1
    fi
    list_file_types_with_example "$directory"
}

main "$@"
