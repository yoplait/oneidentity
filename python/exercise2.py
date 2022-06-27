import json
import requests

##########################################################################################
# Exercise 2: Find all ships that have a hyperdrive rating >= 1.0
# https://swapi.dev/api/starships
# hyperdrive rating >= 1.0

def crawl(link):
	response = requests.get(link)
	api_results = json.loads(response.content)
	# print(api_results)
	for starship in api_results['results']:
		if starship['hyperdrive_rating'] >= 1:
			print(starship['name'])
	if 'next' in api_results  and api_results['next'] is not None:
		next_page = crawl(api_results['next'])
		for page in next_page:
			yield page

ships = crawl('https://swapi.dev/api/starships')
for results in ships:
	print(results)

