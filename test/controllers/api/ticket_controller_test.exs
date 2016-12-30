defmodule TicketPoker.API.TicketControllerTest do
  use TicketPoker.ConnCase

  alias TicketPoker.Ticket

  @valid_attrs %{
    url:            "some content",
    point_options:  [1, 2, 3],
    estimates:      %{}
  }
  @invalid_attrs %{}

  @non_existent_uuid "35bf6df4-69a5-4bd3-a9e5-dddd7d55e3ea"

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "shows chosen resource", %{conn: conn} do
    ticket = Repo.insert! %Ticket{}
    conn = get conn, api_ticket_path(conn, :show, ticket)
    assert json_response(conn, 200)["data"] == %{
      "id"            => ticket.id,
      "url"           => ticket.url,
      "estimates"     => nil,
      "point_options" => nil
    }
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, api_ticket_path(conn, :show, @non_existent_uuid)
    end
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    ticket = Repo.insert! %Ticket{}
    conn = put conn, api_ticket_path(conn, :update, ticket), ticket: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Ticket, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    ticket = Repo.insert! %Ticket{}
    conn = put conn, api_ticket_path(conn, :update, ticket), ticket: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

end
