db-recreate:
	mix ecto.drop
	mix ecto.create
	mix ecto.migrate

db-connect:
	psql -U postgres planning_poker_dev
