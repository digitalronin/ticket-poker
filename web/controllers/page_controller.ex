defmodule TicketPoker.PageController do
  use TicketPoker.Web, :controller

  def about(conn, %{}), do: render(conn, "about.html")
  def api(conn, %{}),   do: render(conn, "api.html")
end
