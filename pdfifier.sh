convert_to_pdf() {
    input_file="$1"
    output_file="${input_file%.*}.pdf"
    
    if [ ! -f "$output_file" ]; then
        echo "Converting $input_file to PDF..."
        if [ "$2" != "test" ]; then
            if [[ "${input_file##*.}" =~ ^(docx|doc|DOCX|DOC|docm)$ ]]; then
                doc2pdf "$input_file"
            fi
        fi
    else
        echo "PDF already exists for $input_file"
    fi
}

traverse_directories() {
    for file in "$1"/*; do
        if [ -d "$file" ]; then
            traverse_directories "$file" "$2"
        elif [[ "${file##*.}" =~ ^(docx|doc|DOCX|DOC|docm)$ ]]; then
            convert_to_pdf "$file" "$2"
        fi
    done
}

main() {
    if [ "$2" = "test" ]; then
        traverse_directories "$1" "test"
    else
        traverse_directories "$1"
    fi
}

main "$@"

