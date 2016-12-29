serve:
	iex -S mix phoenix.server

build-assets:
	node_modules/.bin/brunch build

console:
	iex -S mix

db-recreate:
	mix ecto.drop
	mix ecto.create
	mix ecto.migrate

db-connect:
	pgcli -U postgres planning_poker_dev

curl-json:
	curl -H "Accept: application/json" -H "Content-Type: application/json"  http://localhost:4000/api/tickets/9bd7e27d-2e36-4f15-871b-2f3b4e198aef \
		| python -m json.tool

curl-json-api:
	curl -H "Accept: application/vnd.api+json" -H "Content-Type: application/vnd.api+json"  http://localhost:4000/api/tickets/9bd7e27d-2e36-4f15-871b-2f3b4e198aef \
		| python -m json.tool
