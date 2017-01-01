defmodule TicketPoker.API.TicketView do
  use TicketPoker.Web, :view

  def render("show.json", %{ticket: ticket}) do
    %{data: render_one(ticket, TicketPoker.API.TicketView, "ticket.json")}
  end

  def render("ticket.json", %{ticket: ticket}) do
    %{
      id:             ticket.id,
      url:            ticket.url,
      estimates:      ticket.estimates,
      point_options:  ticket.point_options
    }
  end
end
