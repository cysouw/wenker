#!/bin/sh

# reformate columns from space to tab
# and merge selected columns

#  ./synToLex.sh WS38_1syntax.txt WS38_2lexicon.txt
# header needs to be added manually

outfile=$2

tail -n +2 "$1" |
cut -f1-6 > $outfile

# alle	die	leute	heute	sind	draussen	aufm	feld	und	tun	zu	mähen
for col in 1,11 2,8 3,9,13 4,7,14 6 15,18,25 16,23 17,24 19 20 21 22
do
	tail -n +2 "$1" |
	cut -f7 |
	cut -d' ' -f"$col" |
	tr -d '\r' |
	tr -d ' -' |
	sed -E 's_^$_\-_g' |
	paste $outfile - | sponge $outfile
done
	
