#!/bin/bash

# Fetch the CSV
rm -rf European-Parliament-Open-Data
# TODO: validate if git is installed
git clone https://github.com/eliflab/European-Parliament-Open-Data.git

# Generate the JS file
# TODO: add versioning, based on the version of the CSV
csv=$(tail -n +2 European-Parliament-Open-Data/meps_full_list_with_twitter_accounts.csv);
countries=$(echo "$csv"|cut -d, -f4|sort -u);

echo "$countries" | while read -r country; do
	# Since we have deployed previously, I want to maintain retro-compatibility
	# with older versions, by remaping some countrycodes. Also, white spaces
	# must begone.
	countrycode="$(echo "$country"|sed 's/\ //g'|sed 's/UnitedKingdom/UK/g')";

	echo "var MEPs$countrycode = [";
	meps=$(echo "$csv"|grep "$country,"|cut -d, -f3|grep -v ^$);
	for mep in $meps; do
		echo "\"$(echo $mep|sed 's/@//')\",";
	done;
	echo "];"; 
	echo "";
done
