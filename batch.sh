#!/bin/bash

pass_directory_to_pdfifier() {
    directory="$1"
    echo "Running pdfifier.sh for directory: $directory"
    bash pdfifier.sh "$directory" "$2"
}

run_git_commands() {
    directory="$1"
    echo "Running git commands for directory: $directory"
    git add .
    git commit -m "$directory"
    git push
}

main() {
    if [ "$1" = "test" ]; then
        shift
        for directory in "$@"; do
            pass_directory_to_pdfifier "$directory" "test"
            echo "Running git commands for directory: $directory"
        done
    else
        for directory in "$@"; do
            pass_directory_to_pdfifier "$directory"
            run_git_commands "$directory"
        done
    fi
}

main "$@"
