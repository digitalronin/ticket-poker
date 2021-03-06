defmodule TicketPoker.API.TicketView do
  use TicketPoker.Web, :view

  def render("create.json", %{conn: conn, ticket: ticket}) do
    %{ "url" => ticket_url(conn, :show, ticket) }
  end

  def render("error.json", %{}) do
    %{ "error" => "invalid parameters" }
  end
end
