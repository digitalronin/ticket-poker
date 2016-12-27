defmodule PlanningPoker.TicketControllerTest do
  use PlanningPoker.ConnCase

  alias PlanningPoker.{TeamUpdater}

  @url "http://foo.bar.baz"

  @team_attrs %{
    "coders" => ["a", "b", "c"],
    "name"   => "team name",
    "points" => [1, 2, 3],
    "new_ticket_url" => @url
  }

  test "shows chosen resource", %{conn: conn} do
    {:ok, _team, ticket} = TeamUpdater.create(@team_attrs)
    conn = get conn, ticket_path(conn, :show, ticket)
    assert html_response(conn, 200) =~ "Ticket"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, ticket_path(conn, :show, "35bf6df4-69a5-4bd3-a9e5-dddd7d55e3ea")
    end
  end

end
