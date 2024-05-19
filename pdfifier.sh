#!/bin/bash

convert_docx_to_pdf() {
    input_file="$1"
    output_file="${input_file%.docx}.pdf"
    
    if [ ! -f "$output_file" ]; then
        echo "Converting $input_file to PDF..."
        if [ "$2" != "test" ]; then
            doc2pdf "$input_file"
        fi
    else
        echo "PDF already exists for $input_file"
    fi
}

traverse_directories() {
    for file in "$1"/*; do
        if [ -d "$file" ]; then
            traverse_directories "$file" "$2"
        elif [ "${file##*.}" = "docx" ] || [ "${file##*.}" = "doc" ] || [ "${file##*.}" = "DOC" ] || [ "${file##*.}" = "DOCX" ] || [ "${file##*.}" = "docm" ]; then
            convert_docx_to_pdf "$file" "$2"
        fi
    done
}

main() {
    if [ "$2" = "test" ]; then
        traverse_directories "$1" "test" > conversion_log.txt
    else
        traverse_directories "$1" > conversion_log.txt
    fi
}

main "$@"
