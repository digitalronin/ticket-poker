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
