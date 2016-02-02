#!/bin/bash
for name in $(cat $1)
do
echo -n "The reads of ${name}:">${name}.state
zcat ${name} | paste - - - - | cut -f1 | wc -l >>${name}.state
#echo
echo -n "The bases of ${name}:">>${name}.state
zcat ${name} | paste - - - - | cut -f2 | tr -d '\n' | wc -c >>${name}.state
done 
