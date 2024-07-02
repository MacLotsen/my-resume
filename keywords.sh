#!/bin/bash

# Check for the required argument
if [ -z "$1" ]; then
  echo "Usage: $0 <input_file>"
  exit 1
fi

input_file=$1

# Extract and format keywords from the input file (resume.tex)
sed -n "s/.*\\keywords{\(.*\)}$/\1/p" "$input_file" |
  grep -Ev '^%' |
  grep -Ev '^$' |
  sed "s/, /\n/g" |
  sed "s/\\\\//g" |
  sort | uniq |
  sed '2,$s/^/          /' |
  sed -e 's/$/\\sep/g' |
  sed -e '$ s/\\sep//'
