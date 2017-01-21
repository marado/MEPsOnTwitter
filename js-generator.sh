#!/bin/bash

# Fetch the CSV
rm -rf European-Parliament-Open-Data
# TODO: validate if git is installed
git clone https://github.com/eliflab/European-Parliament-Open-Data.git

# Generate the JS file
csv=$(tail -n +2 European-Parliament-Open-Data/meps_full_list_with_twitter_accounts.csv);
countries=$(echo "$csv"|cut -d, -f4|sort -u);

echo "/*";
echo " * MEPsOnTwitter: a list of MEPs, by country, and their twitter accounts.";
echo " * Automaticly generated by https://github.com/marado/MEPsOnTwitter";
echo " * Source data from https://github.com/eliflab/European-Parliament-Open-Data";
echo " * Data license: http://opendatacommons.org/licenses/odbl/1.0/";
# TODO: add versioning, based on the version of the CSV
echo " */";

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
