#!/bin/sh

# extract one column

# three arguments:
# - number of column in alignment
# - infile
# - outfile

tail -n +2 "$2" |
cut -f5 |
cut -d' ' -f$1 |
tr -d ' -' |
paste meta.txt - > "$3"

#echo 'Index	Bogennummer	REDE_Namen	Sprache	WS9' | cat - "$3" | tee "$3"
