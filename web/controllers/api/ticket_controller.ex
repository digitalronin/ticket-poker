defmodule TicketPoker.API.TicketController do
  use TicketPoker.Web, :controller

  alias TicketPoker.{Repo, Team, TicketUpdater}

  def create(conn, %{"team_id" => team_id, "ticket_url" => ticket_url}) do
    try do
      team = Repo.get!(Team, team_id)
      {:ok, _team, ticket} = TicketUpdater.create(team, %{ "new_ticket_url" => ticket_url })
      render(conn, "create.json", %{conn: conn, ticket: ticket})
    rescue
      Ecto.Query.CastError -> render(conn, "error.json")
      Ecto.NoResultsError  -> render(conn, "error.json")
      ArgumentError        -> render(conn, "error.json")
    end
  end
end
