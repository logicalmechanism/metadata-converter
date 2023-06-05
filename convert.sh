#!/bin/bash
set -e

# must be 1 input
if [[ ! $# -eq 1 ]] ; then
    echo -e "\033[0;31m\nPlease Supply A Metadata File Path\033[0m";
    echo -e "\033[0;31m./convert.sh path/to/metadata/file.json\n\033[0m";
    exit
fi

# check if valid file path
file_path=${1}
if [[ ! -f $file_path ]]; then
    echo -e "\033[0;31m\nNot A Valid File Path\033[0m";
fi

python3 -c "from convert_metadata import get_metadata_headers; get_metadata_headers('${file_path}')"

# Execute the Python one-liner and capture the output
output=$(python3 -c "from convert_metadata import get_metadata_headers; print(get_metadata_headers('${file_path}'))")

# Remove parentheses and extra spaces
output=$(echo $output | tr -d '()')

# Split the output into three variables
IFS=',' read -r var1 var2 var3 <<< "$output"

# Remove leading and trailing spaces from the variables
tag=$(echo $var1 | xargs)
pid=$(echo $var2 | xargs)
tkn=$(echo $var3 | xargs)
ver=$(jq -r --arg tag "$tag" --arg pid "$pid" '.[$tag] | .version' ${file_path})

python3 -c "from convert_metadata import convert_metadata; convert_metadata('${file_path}', 'metadatum.json', '${tag}', '${pid}', '${tkn}', ${ver})"
