#!/bin/sh

# Prepare substitutions for manual editing
# typically needed for clitics

# two arguments:
# - number of column in alignment
# - infile
# result goes to STDOUT

# read file, ignore header
tail -n +2 $2 |
# only the german/dutch lines
egrep '\t1\t|\t10\t|\t11\t|\t100\t' |
# aligned sentence is in the 5th column
cut -f5 |
# inside of this sentence, choose which column
cut -d' ' -f$1 |
# sort unique occurrences
sort -u |
# escape BREs
sed -E 's_([ \? \[ \* \.\$ /])_\\\1_g' |
sed -E "s_\'_\\\'_g" |
# output to STDOUT including header
( printf '#!/usr/bin/env sed -f\n\n' ; sed -E 's_(.*)_s/ \1 / \1 /_' ; ) |
cat
