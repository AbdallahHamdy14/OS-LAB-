#!/bin/bash

DIR="$1"
MALICIOUS_DIR="$2"

while true; do
    
    shopt -s nullglob
    files=("$MALICIOUS_DIR"/*)
    shopt -u nullglob

    if [ ${#files[@]} -eq 0 ]; then
        echo "No malicious files to review."
        exit 0
    fi

    echo "================================="
    echo "Quarantined Files:"
    
    i=1
    for f in "${files[@]}"; do
        echo "$i) ${f##*/}"
        ((i++))
    done
    echo "0) Exit"
    echo "================================="

    read -p "Select a file by number: " choice

    if [ "$choice" -eq 0 ] 2>/dev/null; then
        break
    fi

    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#files[@]}" ]; then
        selected_file="${files[$((choice-1))]}"
        filename="${selected_file##*/}"

        echo ""
        echo "Selected file: $filename"
        echo "1) Restore this file back into $DIR"
        echo "2) Permanently delete this file"
        echo "3) Leave as-is and go back"
        read -p "Choose an option (1-3): " opt

        case "$opt" in
            1)
                mv "$selected_file" "$DIR/$filename"
                echo "Restored $filename to $DIR."
                ;;
            2)
                rm "$selected_file"
                echo "$filename permanently deleted."
                ;;
            3)
                ;;
            *)
                echo "Invalid option."
                ;;
        esac
    else
        echo "Invalid selection. Please try again."
    fi
    echo ""
done