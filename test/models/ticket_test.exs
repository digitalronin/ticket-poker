defmodule TicketPoker.TicketTest do
  use TicketPoker.ModelCase

  alias TicketPoker.Ticket

  @valid_attrs %{estimates: %{}, point_options: [], url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Ticket.changeset(%Ticket{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Ticket.changeset(%Ticket{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "to_map" do
    ticket = %Ticket{
      id:             "foo",
      url:            "bar",
      point_options:  [1, 2, 3],
      estimates:      %{ "a" => 2, "b" => 3 }
    }

    assert Ticket.to_map(ticket) == %{
      estimates:      %{"a" => 2, "b" => 3},
      point_options:  [1, 2, 3]
    }
  end
end
