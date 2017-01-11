#!/bin/bash

# check dependencies
if ! type wget >/dev/null 2>&1 ; then
	echo "You need wget in order to use this script."
	exit
fi

if ! type dos2unix >/dev/null 2>&1 ; then
	echo "You need wget in order to use this script."
	exit
fi

wget "https://docs.google.com/spreadsheets/d/14Y3MBdIVsKt361l8qMGEecjGkxV5PCOfuKOMptfBB-k/export?format=csv&id=14Y3MBdIVsKt361l8qMGEecjGkxV5PCOfuKOMptfBB-k&gid=0" -o /dev/null -O - | dos2unix |sed 's/,$//g' > MEPs-on-Twitter.csv
bash js-generator.sh > MEPs-on-Twitter.js
