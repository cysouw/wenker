#!/bin/sh

# put all lexicon in tab separated columns

#  ./lexExpand.sh WS_lexicon.txt WS_characters.txt
# header needs to be added manually

outfile=$2

tail -n +2 "$1" |
cut -f1-4 > $outfile

for col in 5 8 9 10 11 12 13 14 15 16 17 18 19
do
	tail -n +2 "$1" |
	cut -f"$col" |
	tr ' ' '\t' |
	paste $outfile - | sponge $outfile
done
	
