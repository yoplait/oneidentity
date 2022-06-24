#!/usr/bin/env bash

##########################################################################################
# Exercise 2: Find all ships that have a hyperdrive rating >= 1.0

clear
URL='https://swapi.dev/api'
PAGE=1

echo ""
echo "Exercise 2: Find all ships that have a hyperdrive rating >= 1.0"
echo ""

while true
do
	response=$( curl -sL -H 'Accept: application/json' ${URL}/starships?page=${PAGE} )
	if [[ ${response} =~ .*detail.*Not.* ]]; then
		break
	fi	
	echo $response | jq '.results[] | select(.hyperdrive_rating>="1.0").name'
	PAGE=$((PAGE + 1))
done
echo ""
echo "API Pages:" $((PAGE - 1))
echo ""