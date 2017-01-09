#!/bin/bash

TEAM_ID=[UUID from your team\'s URL]

TICKET_URL=$1

curl -s -H "Accept: application/json" \
     -H "Content-Type: application/json" \
	 	 -X POST \
     -d "{\"team_id\":\"${TEAM_ID}\",\"ticket_url\":\"${TICKET_URL}\"}" \
     https://ticket-poker.herokuapp.com/api/tickets \
     | sed 's/{"url":"\(.*\)"}/\1/'

