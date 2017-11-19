#!/bin/sh

# Prepare substitutions for manual editing
# typically needed for clitics

# use as pipe from 'listForms.sh'
# e.g.: 4th column from alignment
# ./listForms.sh 4 file | ./prepareReplace.sh

# escape BREs
sed -E 's_([ \? \[ \* \.\$ /])_\\\1_g' |
# escape apostrophes
sed -E "s_\'_\\\'_g" |
# output sed-replace to STDOUT including header
( printf '#!/usr/bin/env sed -f\n\n' ; sed -E 's_(.*)_s/ \1 / \1 /_' ; ) |
cat
