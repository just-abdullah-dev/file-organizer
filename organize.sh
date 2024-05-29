#!/bin/bash

# Define the directory to organize
TARGET_DIR="$1"
INCLUDE_SUBDIRS=false
SKIP_DIR=""

# Parse additional arguments
shift
while [[ "$1" != "" ]]; do
    case $1 in
        -subdir)
            INCLUDE_SUBDIRS=true
            ;;
        -skip)
            shift
            SKIP_DIR="$1"
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
    shift
done

# Check if directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo "Directory $TARGET_DIR does not exist."
    exit 1
fi

# Define file type to directory mappings
declare -A FILE_TYPES
FILE_TYPES=(
    # Text Files
    ["txt"]="TextFiles"
    
    # Images
    ["jpg"]="Images"
    ["jpeg"]="Images"
    ["png"]="Images"
    ["gif"]="Images"
    ["bmp"]="Images"
    ["tiff"]="Images"
    ["svg"]="Images"
    ["webp"]="Images"
    ["ico"]="Images"

    # Audio Files
    ["mp3"]="Music"
    ["wav"]="Music"
    ["flac"]="Music"
    ["aac"]="Music"
    ["ogg"]="Music"
    ["wma"]="Music"
    ["m4a"]="Music"

    # Video Files
    ["mp4"]="Videos"
    ["avi"]="Videos"
    ["mkv"]="Videos"
    ["flv"]="Videos"
    ["mov"]="Videos"
    ["wmv"]="Videos"
    ["webm"]="Videos"
    ["mpeg"]="Videos"
    ["mpg"]="Videos"

    # Document Files
    ["doc"]="Docs"
    ["docx"]="Docs"
    ["pdf"]="Docs"
    ["xls"]="Docs"
    ["xlsx"]="Docs"
    ["ppt"]="Docs"
    ["pptx"]="Docs"
    ["odt"]="Docs"
    ["ods"]="Docs"
    ["odp"]="Docs"
    ["rtf"]="Docs"

    # Compressed Files
    ["zip"]="Archives"
    ["rar"]="Archives"
    ["tar"]="Archives"
    ["gz"]="Archives"
    ["7z"]="Archives"
    ["bz2"]="Archives"
    ["xz"]="Archives"

    # Coding Files
    ["c"]="Code"
    ["cpp"]="Code"
    ["java"]="Code"
    ["py"]="Code"
    ["js"]="Code"
    ["html"]="Code"
    ["css"]="Code"
    ["php"]="Code"
    ["rb"]="Code"
    ["go"]="Code"
    ["rs"]="Code"
    ["sh"]="Code"
    ["swift"]="Code"
    ["pl"]="Code"
    ["lua"]="Code"
    ["sql"]="Code"
    ["xml"]="Code"
    ["json"]="Code"
    ["yml"]="Code"
    ["yaml"]="Code"

    # Other/Unknown Files
    [""]="Others"
)

# Create directories if they do not exist
for DIR in "${FILE_TYPES[@]}"; do
    if [ ! -d "$TARGET_DIR/$DIR" ]; then
        mkdir -p "$TARGET_DIR/$DIR"
    fi
done

# Function to move files
move_files() {
    local search_dir="$1"
    find "$search_dir" -type f | while read -r FILE; do
        # Skip files in the specified directory
        if [[ "$SKIP_DIR" != "" && "$FILE" == "$TARGET_DIR/$SKIP_DIR/"* ]]; then
            continue
        fi
        EXT="${FILE##*.}"
        if [[ ${FILE_TYPES[$EXT]} ]]; then
            mv "$FILE" "$TARGET_DIR/${FILE_TYPES[$EXT]}"
            echo "Moved $FILE to $TARGET_DIR/${FILE_TYPES[$EXT]}"
        else
            mv "$FILE" "$TARGET_DIR/Others"
            echo "Moved $FILE to $TARGET_DIR/Others"
        fi
    done
}

# Move files in the target directory and optionally in subdirectories
if $INCLUDE_SUBDIRS; then
    if [[ "$SKIP_DIR" != "" ]]; then
        find "$TARGET_DIR" -type d -name "$SKIP_DIR" -prune -o -type f -print | while read -r FILE; do
            EXT="${FILE##*.}"
            if [[ ${FILE_TYPES[$EXT]} ]]; then
                mv "$FILE" "$TARGET_DIR/${FILE_TYPES[$EXT]}"
                echo "Moved $FILE to $TARGET_DIR/${FILE_TYPES[$EXT]}"
            else
                mv "$FILE" "$TARGET_DIR/Others"
                echo "Moved $FILE to $TARGET_DIR/Others"
            fi
        done
    else
        move_files "$TARGET_DIR"
    fi
else
    find "$TARGET_DIR" -maxdepth 1 -type f | while read -r FILE; do
        EXT="${FILE##*.}"
        if [[ ${FILE_TYPES[$EXT]} ]]; then
            mv "$FILE" "$TARGET_DIR/${FILE_TYPES[$EXT]}"
            echo "Moved $FILE to $TARGET_DIR/${FILE_TYPES[$EXT]}"
        else
            mv "$FILE" "$TARGET_DIR/Others"
            echo "Moved $FILE to $TARGET_DIR/Others"
        fi
    done
fi

# Delete empty directories
find "$TARGET_DIR" -type d -empty -delete

echo "File organization complete."
