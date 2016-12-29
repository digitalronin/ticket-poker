defmodule PlanningPoker.TicketController do
  use PlanningPoker.Web, :controller

  alias PlanningPoker.Ticket

  def show(conn, %{"id" => id}) do
    ticket = Repo.get!(Ticket, id)
    render(conn, "show.html", ticket: ticket)
  end
end
