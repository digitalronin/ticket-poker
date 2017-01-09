defmodule TicketPoker.API.TicketControllerTest do
  use TicketPoker.ConnCase

  alias TicketPoker.{Ticket, TeamUpdater, Repo}

  @url "http://foo.bar.baz"

  @team_attrs %{
    "coders" => ["a", "b", "c"],
    "name"   => "team name",
    "points" => [1, 2, 3]
  }

  setup %{conn: conn} do
    {:ok, team, _ticket} = TeamUpdater.create(@team_attrs)

    params = %{ticket_url: @url, team_id: team.id}

    {
      :ok,
      conn:   put_req_header(conn, "accept", "application/json"),
      params: params
    }
  end

  test "returns url of the new ticket", %{conn: conn, params: params} do
    conn = post conn, api_ticket_path(conn, :create, params)
    ticket = Repo.one(from t in Ticket, select: t, limit: 1)
    assert json_response(conn, 200) == %{"url" => ticket_url(conn, :show, ticket)}
  end

  test "creates a new ticket", %{conn: conn, params: params} do
    post conn, api_ticket_path(conn, :create, params)
    assert Repo.one(from t in Ticket, select: count(t.id)) == 1
  end
end
