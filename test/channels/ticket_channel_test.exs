defmodule TicketPoker.TicketChannelTest do
  use TicketPoker.ChannelCase

  alias TicketPoker.{TicketChannel, TeamUpdater}

  @team_attrs %{
    "coders"         => ["a", "b", "c"],
    "name"           => "team name",
    "points_string"  => "1 2 3",
    "new_ticket_url" => "http://foo.bar.baz"
  }

  @ticket_id "35bf6df4-69a5-4bd3-a9e5-dddd7d55e3ea"

  setup do
    {:ok, _, socket} =
      socket("user_id", %{some: :assign})
      |> subscribe_and_join(TicketChannel, "ticket:#{@ticket_id}")

    {:ok, socket: socket}
  end

  test "update broadcasts to channel", %{socket: socket} do
    {:ok, _team, ticket} = TeamUpdater.create(@team_attrs)

    message = %{ "ticket_id" => ticket.id, "coder" => "a", "points" => 5 }
    push socket, "update", message

    assert_broadcast "update", %{
      point_options: [1, 2, 3],
      estimates:     %{ "a" => 5, "b" => 0, "c" => 0 }
    }
  end

  test "get_ticket fetches ticket state", %{socket: socket} do
    {:ok, _team, ticket} = TeamUpdater.create(@team_attrs)

    message = %{ "ticket_id" => ticket.id }
    push socket, "get_ticket", message

    assert_push "update", %{
      point_options: [1, 2, 3],
      estimates:     %{ "a" => 0, "b" => 0, "c" => 0 }
    }
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from! socket, "broadcast", %{"some" => "data"}
    assert_push "broadcast", %{"some" => "data"}
  end
end
