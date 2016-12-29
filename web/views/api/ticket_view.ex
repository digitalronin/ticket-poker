defmodule PlanningPoker.API.TicketView do
  use PlanningPoker.Web, :view

  def render("show.json", %{ticket: ticket}) do
    %{data: render_one(ticket, PlanningPoker.API.TicketView, "ticket.json")}
  end

  def render("ticket.json", %{ticket: ticket}) do
    %{
      id:   ticket.id,
      url:  ticket.url
    }
  end
end
