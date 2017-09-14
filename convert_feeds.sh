#!/bin/bash
#OpenSource Threat Feed Downloader -> Step 2: Converter
#GITHUB: BREAKANDINSPECT
#Use: ./convert_feeds.sh input_filename output_filename "delimeter"
#      delimeter can be "," ";" "#" or whatever you need. See Step 1 for details. 
#rm -rf $2 #only used for DEBUG. 
i=0
cat $1 | while read line
do
 let i++
 echo "$i$3$line" >> $2
done  
