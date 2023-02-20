#!/bin/zsh

for file in lecture01*; do
    if ! grep -Fq "$file" $file; then
        gsed -i "1i\\% $file\
\
" $file
    fi
done

