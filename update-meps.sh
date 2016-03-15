#!/bin/bash

# uncomment this to production
wget "http://www.europarl.europa.eu/meps/en/xml.html?query=full&filter=all" -O all-meps.xml

# the following command will give you the MEP names... but in a different format
# xml2 < all-meps.xml |grep fullName|sort -u|cut -d= -f2-

# so let's transform it to the format used in the CSV:
# real
for linenumber in $(seq 1 $(xml2 < all-meps.xml |grep fullName|cut -d= -f2-|wc -l)); do 
# testing with just the first line for dev purposes
#for linenumber in $(seq 1 1); do 
	line=$(xml2 < all-meps.xml |grep fullName|cut -d= -f2-|head -n $linenumber|tail -n 1);
	lowercase=$(echo $(for word in $(echo $line); do echo $word | egrep "[^[:upper:] ]"; done)|sed ':a;N;$!ba;s/\n/ /g');
	uppercase=$(echo $(for word in $(echo $line); do echo $word | egrep -v "[^[:upper:] ]"; done)|sed ':a;N;$!ba;s/\n/ /g');
	# echo "Name: $lowercase; Surname: $uppercase";
	echo "$uppercase $lowercase";
done > all-meps.txt

for i in $(seq 1 $(cat all-meps.txt|wc -l)); do echo -n "$(head all-meps.txt -n$i|tail -n1):"; grep "$(head all-meps.txt -n$i|tail -n1)" MEPs-on-Twitter.csv|wc -l; done > found.txt


