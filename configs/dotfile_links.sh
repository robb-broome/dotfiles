#!/bin/sh 
for file in _*
do
   ln -s -n -f `pwd`/$file $HOME/${file/#_/.}
done
