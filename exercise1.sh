#!/usr/bin/env bash

##########################################################################################
# Exercise 1: Find all ships that appeared in Return of the Jedi
clear
URL='https://swapi.dev/api'
PAGE=1

while true
do
	response=$( curl -sL -H 'Accept: application/json' ${URL}/films?page=${PAGE} )
	if [[ ${response} =~ .*detail.*Not.* ]]; then
		break
	fi
	# echo $response | jq .
	# logic
	RESULTS=`echo $response | jq '.results[] | select(.title=="Return of the Jedi").starships'`
	COUNTER=`echo $response | jq '.results[] | select(.title=="Return of the Jedi").starships' | jq length`
	for i in $(seq 0 $COUNTER); 
	do 
		# echo $COUNTER
		SUB_URL=`echo $RESULTS | jq -r .[$i]`
		# echo $SUB_URL
		curl -sL -H 'Accept: application/json' ${SUB_URL} | jq ".name"
	done
	PAGE=$((PAGE + 1))
done
echo ""
echo "API Pages:" $((PAGE - 1))
echo ""