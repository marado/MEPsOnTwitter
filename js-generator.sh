#!/bin/bash

# Validate dependencies
command -v git >/dev/null 2>&1 || { echo >&2 "You need to install git to use this.  Aborting."; exit 1; }

# Fetch the CSV
rm -rf European-Parliament-Open-Data
git clone https://github.com/eliflab/European-Parliament-Open-Data.git

# Generate the JS file
csv=$(tail -n +2 European-Parliament-Open-Data/meps_full_list_with_twitter_accounts.csv);
countries=$(echo "$csv"|cut -d, -f4|sort -u);
version=$(grep refs/remotes/origin/master European-Parliament-Open-Data/.git/packed-refs|cut -d" " -f1);

echo "/*";
echo " * MEPsOnTwitter: a list of MEPs, by country, and their twitter accounts.";
echo " * Automaticly generated by https://github.com/marado/MEPsOnTwitter";
echo " * Source data from https://github.com/eliflab/European-Parliament-Open-Data";
echo "   (revision: $version)";
echo " * Data license: http://opendatacommons.org/licenses/odbl/1.0/";
echo " */";

echo "$countries" | while read -r country; do
	# Since we have deployed previously, I want to maintain retro-compatibility
	# with older versions, by remaping some countrycodes. Also, white spaces
	# must begone.
	countrycode="$(echo "$country"|sed 's/\ //g'|sed 's/UnitedKingdom/UK/g')";

	echo "var MEPs$countrycode = [";
	meps=$(echo "$csv"|grep "$country,"|cut -d, -f3|grep -v ^$);
	for mep in $meps; do
		echo "\"${mep/@/}\",";
	done;
	echo "];"; 
	echo "";
done
