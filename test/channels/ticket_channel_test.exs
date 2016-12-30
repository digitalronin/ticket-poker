defmodule TicketPoker.TicketChannelTest do
  use TicketPoker.ChannelCase

  alias TicketPoker.TicketChannel

  @ticket_id "35bf6df4-69a5-4bd3-a9e5-dddd7d55e3ea"

  setup do
    {:ok, _, socket} =
      socket("user_id", %{some: :assign})
      |> subscribe_and_join(TicketChannel, "ticket:#{@ticket_id}")

    {:ok, socket: socket}
  end

  test "update broadcasts to channel", %{socket: socket} do
    push socket, "update", %{}
    assert_broadcast "update", %{}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from! socket, "broadcast", %{"some" => "data"}
    assert_push "broadcast", %{"some" => "data"}
  end
end
