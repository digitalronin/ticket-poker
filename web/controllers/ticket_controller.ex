defmodule TicketPoker.TicketController do
  use TicketPoker.Web, :controller

  alias TicketPoker.Ticket

  def show(conn, %{"id" => id}) do
    ticket = Repo.get!(Ticket, id)
    render(conn, "show.html", title: "Ticket", ticket: ticket)
  end
end
