serve:
	iex -S mix phoenix.server

deploy:
	git push heroku master

build-assets:
	node_modules/.bin/brunch build

console:
	iex -S mix

db-recreate:
	mix ecto.drop
	mix ecto.create
	mix ecto.migrate

db-connect:
	pgcli -U postgres ticket_poker_dev

push-github:
	git push github github:master
