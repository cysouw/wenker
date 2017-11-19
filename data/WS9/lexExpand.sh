#!/bin/sh

# put all lexicon in tab separated columns

#  ./lexExpand.sh WS9_lexicon.txt WS9_characters.txt
# header needs to be added manually

outfile=$2

tail -n +2 "$1" |
cut -f1-4 > $outfile

for col in `seq 5 37`
do
	tail -n +2 "$1" |
	cut -f"$col" |
	tr ' ' '\t' |
	paste $outfile - | sponge $outfile
done
	
