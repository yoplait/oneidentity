import json
import requests

##########################################################################################
# Exercise 1: Find all ships that appeared in Return of the Jedi
# https://swapi.dev/api/films/3/
# return_jedi


def crawl(link):
	response = requests.get(link)
	api_results = json.loads(response.content)
	# print(api_results)
	for starship in api_results['results']:
		if 'https://swapi.dev/api/films/3/' in starship['films']:
			yield starship['name']
	if 'next' in api_results  and api_results['next'] is not None:
		next_page = crawl(api_results['next'])
		for page in next_page:
			yield page

force_awakenes = crawl('https://swapi.dev/api/starships')
for results in force_awakenes:
	print(results)
