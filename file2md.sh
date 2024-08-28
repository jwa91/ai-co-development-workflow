#!/bin/zsh

# Function to find the correct path for a command
find_command() {
    command -v "$1" || { echo "Error: $1 not found" >&2; exit 1; }
}

# Define paths for commands
WC=$(find_command "wc")
TR=$(find_command "tr")
CAT=$(find_command "cat")
PBCOPY=$(find_command "pbcopy")
RM=$(find_command "rm")

# Determine the directory of the script
SCRIPT_DIR="${0:A:h}"

# Extract filename from path
get_filename() {
    echo "${1##*/}"
}

# Function to convert file content to markdown
convert_file_to_md() {
    local file="$1"
    local chars=$($WC -c < "$file" | $TR -d ' ')
    local filename=$(get_filename "$file")
    local content=$($CAT "$file")
    echo "## $filename"
    echo '```'
    echo "$content"
    echo '```'
    echo "$filename|$chars"
}

# Function to add file content and count characters
add_file_content() {
    local file="$1"
    local content=""
    local chars=0
    if [ -f "$file" ]; then
        content=$($CAT "$file")
        chars=$($WC -c < "$file" | $TR -d ' ')
        echo "$content"
    fi
    echo "|$chars"
}

# Function to handle file processing
process_file() {
    local file="$1"
    local result=""
    
    if [ ! -f "$file" ]; then
        file_info+="  ❌ $(get_filename "$file") not found\n"
        return 1
    fi

    if [ ! -r "$file" ]; then
        file_info+="  ❌ $(get_filename "$file") could not open/read\n"
        return 1
    fi

    if [ ! -s "$file" ]; then
        file_info+="  ❌ $(get_filename "$file") was empty\n"
        return 1
    fi

    result=$(convert_file_to_md "$file")
    output+="${result%$'\n'*}"$'\n\n'
    file_info+="  ✅ $(get_filename "$file") added - ${result##*|} characters\n"
    total_chars=$((total_chars + ${result##*|}))
    ((files_processed++))
    return 0
}

# Function to process a directory
process_directory() {
    local dir="$1"
    for file in "$dir"/*; do
        if [ -f "$file" ]; then
            process_file "$file"
        fi
    done
}

# Main script
output=""
file_info=""
structure_content=""
instructions_content=""
total_chars=0
files_processed=0

# Process command-line arguments
add_structure=false
while getopts ":s" opt; do
    case ${opt} in
        s ) add_structure=true ;;
        \? ) echo "Usage: $0 [-s]" >&2
             exit 1 ;;
    esac
done

FILES_TXT="$SCRIPT_DIR/files.txt"

if [ ! -f "$FILES_TXT" ]; then
    echo "Error: files.txt not found in $SCRIPT_DIR" >&2
    exit 1
fi

# Add structure.md if -s option is used
if $add_structure; then
    structure_result=$(add_file_content "$SCRIPT_DIR/structure.md")
    structure_content="${structure_result%|*}"
    structure_chars="${structure_result#*|}"
    output+="$structure_content"$'\n\n'
    total_chars=$((total_chars + structure_chars))
    file_info+="  ✅ structure.md added - $structure_chars characters\n"
fi

while IFS= read -r path || [ -n "$path" ]; do
    if [ -f "$path" ]; then
        process_file "$path"
    elif [ -d "$path" ]; then
        process_directory "$path"
    else
        file_info+="  ❌ $path is not a valid file or directory\n"
    fi
done < "$FILES_TXT"

# Add instructions.md
instructions_result=$(add_file_content "$SCRIPT_DIR/instructions.md")
instructions_content="${instructions_result%|*}"
instructions_chars="${instructions_result#*|}"
output+="$instructions_content"
total_chars=$((total_chars + instructions_chars))
file_info+="  ✅ instructions.md added - $instructions_chars characters\n"

# Calculate token count (1 token = 4 characters)
total_tokens=$((total_chars / 4))

# Save & copy if files were processed
if [ $files_processed -gt 0 ]; then
    echo "$output" > "$SCRIPT_DIR/output.md"
    echo "$output" | $PBCOPY

    # Display in terminal with refined colors and alignment
    GREEN='\033[0;32m'
    RED='\033[0;31m'
    WHITE='\033[1;37m'
    BLUE='\033[1;34m'
    NC='\033[0m' # No Color

    # Create aligned output using printf for better formatting
    echo -e "${BLUE}📂 Processed files:${NC}"
    echo -e "$file_info" | while read -r line; do
        printf "%-40s\n" "$line"
    done
    echo "----------------------------------------"
    printf "${GREEN}📊 TOTAL CHARACTER COUNT: ${WHITE}%d${NC}\n" "$total_chars"
    printf "${GREEN}🔢 TOTAL TOKEN COUNT:     ${WHITE}%d${NC}\n" "$total_tokens"
    echo "----------------------------------------"
    echo -e "${WHITE}📋 Output has been copied to the clipboard.${NC}"
    echo -e "${WHITE}📁 Output has been saved to:${NC}"
    echo -e "${GREEN} $SCRIPT_DIR/output.md${NC}"
else
    echo -e "${RED}⚠️  No files processed. Please check the contents of files.txt.${NC}"
fi
