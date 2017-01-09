defmodule TicketPoker.API.TicketController do
  use TicketPoker.Web, :controller

  alias TicketPoker.{Repo, Team, TicketUpdater}

  def create(conn, %{"team_id" => team_id, "ticket_url" => ticket_url}) do
    team = Repo.get!(Team, team_id)
    {:ok, _team, ticket} = TicketUpdater.create(team, %{ "new_ticket_url" => ticket_url })
    render(conn, "create.json", %{conn: conn, ticket: ticket})
  end
end
