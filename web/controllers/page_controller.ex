defmodule TicketPoker.PageController do
  use TicketPoker.Web, :controller

  def about(conn, %{}) do
    render(conn, "about.html")
  end
end
