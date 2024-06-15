convert_to_pdf() {
    input_file="$1"
    
    echo "Converting $input_file to PDF..."
    pdfbook2 "$input_file"
}

traverse_directories() {
    for file in "$1"/*; do
        if [ -d "$file" ]; then
            traverse_directories "$file" "$2"
        elif [[ "${file##*.}" =~ ^(pdf|PDF)$ ]]; then
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

