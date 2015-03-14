#!/bin/bash

csv=$(count=$(wc -l < MEPs-on-Twitter.csv);tail -n $(expr $count - 1) MEPs-on-Twitter.csv);
countries=$(echo "$csv"|cut -d, -f4|sort -u);
for country in $countries; do 
	echo "var MEPs$country = [";
	meps=$(echo "$csv"|grep "$country$"|cut -d, -f2|grep -v ^$);
	for mep in $meps; do
		echo "\"$(echo $mep|sed 's/@//')\",";
	done;
	echo "];"; 
	echo "";
done
