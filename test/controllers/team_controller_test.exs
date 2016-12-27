defmodule PlanningPoker.TeamControllerTest do
  use PlanningPoker.ConnCase

  alias PlanningPoker.{Team, Ticket}

  @find_attrs %{coders: [], name: "some content", points: []}
  @valid_attrs Map.put(@find_attrs, :points_string, "")
  @ticket_url "http://foo.bar.baz"
  @invalid_attrs %{}

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, team_path(conn, :new)
    assert html_response(conn, 200) =~ "New team"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, team_path(conn, :create), team: @valid_attrs
    team = Repo.one(from t in Team, select: t, limit: 1)
    assert redirected_to(conn) == team_path(conn, :show, team)
    assert Repo.get_by(Team, @find_attrs)
  end

  test "redirects to ticket page after create, if ticket created", %{conn: conn} do
    conn = post conn, team_path(conn, :create), team: Map.put(@valid_attrs, "new_ticket_url", @ticket_url)
    ticket = Repo.one(from t in Ticket, select: t, limit: 1)
    assert redirected_to(conn) == ticket_path(conn, :show, ticket)
    assert Repo.get_by(Team, @find_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, team_path(conn, :create), team: @invalid_attrs
    assert html_response(conn, 200) =~ "New team"
  end

  test "shows chosen resource", %{conn: conn} do
    team = Repo.insert! %Team{}
    conn = get conn, team_path(conn, :show, team)
    assert html_response(conn, 200) =~ "Edit team"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, team_path(conn, :show, "35bf6df4-69a5-4bd3-a9e5-dddd7d55e3ea")
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    team = Repo.insert! %Team{}
    conn = get conn, team_path(conn, :show, team)
    assert html_response(conn, 200) =~ "Edit team"
  end

  test "redirects back to team/show, if no ticket created", %{conn: conn} do
    team = Repo.insert! %Team{}
    conn = put conn, team_path(conn, :update, team), team: @valid_attrs
    assert redirected_to(conn) == team_path(conn, :show, team)
    assert Repo.get_by(Team, @find_attrs)
  end

  test "redirects to ticket page, if ticket created", %{conn: conn} do
    team = Repo.insert! %Team{}
    conn = put conn, team_path(conn, :update, team), team: Map.put(@valid_attrs, "new_ticket_url", @ticket_url)
    ticket = Repo.one(from t in Ticket, select: t, limit: 1)
    assert redirected_to(conn) == ticket_path(conn, :show, ticket)
    assert Repo.get_by(Team, @find_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    team = Repo.insert! %Team{}
    conn = put conn, team_path(conn, :update, team), team: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit team"
  end

end
