defmodule PlanningPoker.TeamUpdaterTest do
  use PlanningPoker.ModelCase
  alias PlanningPoker.{TeamUpdater, Team, Ticket, Repo}

  @team_attrs %{
    "coders" => ["a", "b", "c"],
    "name"   => "team name",
    "points" => [1, 2, 3]
  }

  @ticket_url "http://foo.bar.baz"

  # create

  test "creates team but no ticket" do
    {:ok, team, ticket} = TeamUpdater.create(@team_attrs)
    assert team.name == "team name"
    assert ticket == nil
    assert count_records(Team) == 1
    assert count_records(Ticket) == 0
  end

  test "creates team and ticket" do
    params = Map.put(@team_attrs, "new_ticket_url", @ticket_url)
    {:ok, team, ticket} = TeamUpdater.create(params)
    t = Repo.one(from t in Ticket, select: t, limit: 1)
    assert ticket.id == t.id
    assert team.name == "team name"
    assert count_records(Team) == 1
    assert count_records(Ticket) == 1
  end

  # update

  test "updates team attributes" do
    {:ok, team, ticket} = TeamUpdater.create(@team_attrs)
    id = team.id
    TeamUpdater.update(team, %{"name" => "new team name"})
    team = Repo.get(Team, id)
    assert ticket == nil
    assert team.name == "new team name"
  end

  test "creates ticket with new team attributes" do
    {:ok, team, _ticket} = TeamUpdater.create(@team_attrs)
    params = @team_attrs
             |> Map.put("points_string", "2 4 8")
             |> Map.put("new_ticket_url", @ticket_url)
    TeamUpdater.update(team, params)
    t = Repo.one(from t in Ticket, select: t, limit: 1)
    assert t.point_options == [2, 4, 8]
  end

  defp count_records(model) do
    Repo.aggregate(model, :count, :id)
  end

end

