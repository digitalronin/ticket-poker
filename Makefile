db-recreate:
	mix ecto.drop
	mix ecto.create
	mix ecto.migrate

db-connect:
	pgcli -U postgres planning_poker_dev
