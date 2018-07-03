#!/bin/sh

# reformate columns from space to tab
# and merge selected columns

#  ./synToLex.sh WS34_1syntax.txt WS34_2lexicon.txt
# header needs to be added manually

outfile=$2

tail -n +2 "$1" |
cut -f1-6 > $outfile

for col in 2 4 6 7 10 11 9,12
do
	tail -n +2 "$1" |
	cut -f7 |
	cut -d' ' -f"$col" |
	tr -d '\r' |
	tr -d ' -' |
	sed -E 's_^$_\-_g' |
	paste $outfile - | sponge $outfile
done
	
