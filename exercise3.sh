#!/usr/bin/env bash

##########################################################################################
# Exercise 3: Find all ships that have crews between 3 and 100

clear
URL='https://swapi.dev/api'
PAGE=1

echo ""
echo "Exercise 3: Find all ships that have crews between 3 and 100"
echo ""

while true
do
	response=$( curl -sL -H 'Accept: application/json' ${URL}/starships?page=${PAGE} )
	if [[ ${response} =~ .*detail.*Not.* ]]; then
		break
	fi	
	# logic
	# echo $response | jq ".results[] | {Name: .name, Crew: .crew}" 
	COUNTER=`echo $response | jq length`
	RESULTS=`echo $response | jq '.results[]'`
	echo $COUNTER
	# echo $RESULTS
	# echo $RESULTS | jq .[1]
	# echo $RESULTS | jq -r .[1]
	for i in $(seq 0 $COUNTER); 
	do 
		# echo $COUNTER
		# SUB_URL=`echo $RESULTS | jq -r '.results[$i]'`
		# NAME=`echo $RESULTS | jq ".[0].name"`
		# CREW_AMOUNT=`echo $response | jq ".results[].crew"`
		NAME=`echo $response | jq ".results[${i}].name"`
		CREW_AMOUNT=`echo $response | jq ".results[${i}].crew"`
		echo "NAME:"$NAME
		echo "CREW:"$CREW_AMOUNT
		# if (( $CREW_AMOUNT > 1 )) || (( $CREW_AMOUNT < 100 )); then
		if [ $((CREW_AMOUNT)) -lt 100 ] || [$((CREW_AMOUNT)) -gt 3 ] ; then
    	echo "NAME:"$NAME
		echo "CREW:"$CREW_AMOUNT
		fi
		# echo $SUB_URL
		# curl -sL -H 'Accept: application/json' ${SUB_URL} | jq ".name"
	done
	PAGE=$((PAGE + 1))
done
echo ""
echo "API Pages:" $((PAGE - 1))
echo ""