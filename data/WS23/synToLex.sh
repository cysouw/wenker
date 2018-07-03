#!/bin/sh

# reformate columns from space to tab
# and merge selected columns

#  ./synToLex.sh WS23_1syntax.txt WS23_2lexicon.txt
# header needs to be added manually

outfile=$2

tail -n +2 "$1" |
cut -f1-6 > $outfile

for col in 2,6 3 4 8 9,18 10,17 12 14,15,16
do
	tail -n +2 "$1" |
	cut -f7 |
	cut -d' ' -f"$col" |
	tr -d '\r' |
	tr -d ' -' |
	sed -E 's_^$_\-_g' |
	paste $outfile - | sponge $outfile
done
	
