#!/bin/sh

# reformate columns from space to tab
# and merge selected columns

#  ./synToLex.sh WS9_syntax.txt WS9_lexicon.txt
# header needs to be added manually

outfile=$2

tail -n +2 "$1" |
cut -f1-4 > $outfile

for col in 2 3,7,11,12 4 6 8 9 10 13 14,18,20,28 16 17 19 24 15,25 22,21,26,23,27
do
	tail -n +2 "$1" |
	cut -f5 |
	cut -d' ' -f"$col" |
	tr -d '\r' |
	tr -d ' -' |
	sed -E 's_^$_\-_g' |
	paste $outfile - | sponge $outfile
done
	
