#!/bin/sh

# reformate columns from space to tab
# and merge selected columns

#  ./synToLex.sh WS9_syntax.txt WS9_lexicon.txt
# header needs to be added manually

outfile=$2

tail -n +2 "$1" |
cut -f1-4 > $outfile

for col in 1 2 3,7 4 5 6 8 9 10 11,14 12 13 15 16 17 18,20,22 19 21 23 24 25,39 26,29,34 27,36,38 28,37 30,35 31 32 33
do
	tail -n +2 "$1" |
	cut -f5 |
	cut -d' ' -f"$col" |
	tr -d '\r' |
	tr -d ' -' |
	sed -E 's_^$_\-_g' |
	paste $outfile - | sponge $outfile
done
	
