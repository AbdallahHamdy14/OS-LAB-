#!/bin/bash

DIR="$1"
MALICIOUS_DIR="$2"
INTERVAL="$3"

mkdir -p "$MALICIOUS_DIR"

LAST_INFO="directory-info.last"
NEW_INFO="directory-info.new"

scan_directory() {
    for filepath in "$DIR"/*; do
        [ -e "$filepath" ] || continue
        
        filename="${filepath##*/}"
        is_malicious=0

        case "$filename" in
            *.exe|*.bat|*.vbs|*.scr|*.ps1)
                is_malicious=1
                ;;
        esac

        if [ $is_malicious -eq 0 ]; then
            if grep -iqE "virus|trojan|malware|worm|ransomware" "$filepath"; then
                is_malicious=1
            fi
        fi

        if [ $is_malicious -eq 1 ]; then
            echo "$filename is malicious and it is DELETED"
            cp "$filepath" "$MALICIOUS_DIR/$filename"
            rm "$filepath"
        fi
    done
}

scan_directory
ls -l "$DIR" > "$LAST_INFO"

while true; do
    sleep "$INTERVAL"
    
    ls -l "$DIR" > "$NEW_INFO"
    
    if ! cmp -s "$LAST_INFO" "$NEW_INFO"; then
        scan_directory
        cp "$NEW_INFO" "$LAST_INFO"
    fi
done