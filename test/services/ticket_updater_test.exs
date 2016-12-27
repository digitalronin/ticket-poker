defmodule PlanningPoker.TicketUpdaterTest do
  use PlanningPoker.ModelCase
  alias PlanningPoker.{TeamUpdater, TicketUpdater}

  @team_attrs %{
    "coders"        => ["a", "b", "c"],
    "name"          => "team name",
    "points_string" => "1 2 3"
  }

  @url "http://foo.bar.baz"

  test "no ticket without new_ticket_url" do
    {:ok, team, _} = TeamUpdater.create(@team_attrs)
    assert TicketUpdater.create(team, %{}) == {:ok, team, nil}
  end

  test "no ticket with blank new_ticket_url" do
    {:ok, team, _} = TeamUpdater.create(@team_attrs)
    assert TicketUpdater.create(team, %{ "new_ticket_url" => "" }) == {:ok, team, nil}
  end

  test "creates ticket" do
    {:ok, team, _} = TeamUpdater.create(@team_attrs)
    {:ok, _team, ticket} = TicketUpdater.create(team, %{ "new_ticket_url" => @url })
    assert ticket.url == @url
    assert ticket.point_options == [1, 2, 3]
    assert ticket.estimates == %{ "a" => 0, "b" => 0, "c" => 0 }
  end

  test "updates an estimate" do
    {:ok, team, _} = TeamUpdater.create(@team_attrs)
    {:ok, _team, ticket} = TicketUpdater.create(team, %{ "new_ticket_url" => @url })

    {:ok, ticket} = TicketUpdater.update_estimate(ticket, "b", 5)

    assert ticket.estimates == %{ "a" => 0, "b" => 5, "c" => 0 }
  end

end

