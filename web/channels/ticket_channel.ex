defmodule TicketPoker.TicketChannel do
  use TicketPoker.Web, :channel
  alias TicketPoker.{TicketUpdater, Ticket, Repo}

  def join("ticket:" <> _ticket_id, _payload, socket) do
    {:ok, socket}
  end

  def handle_in("get_ticket", %{ "ticket_id" => ticket_id }, socket) do
    ticket = Repo.get(Ticket, ticket_id)
    push socket, "update", Ticket.to_map(ticket)
    {:noreply, socket}
  end

  # When we receive an update message, apply the update to the
  # ticket, and broadcast the new ticket state
  def handle_in("update", payload = %{ "ticket_id" => ticket_id, "coder" => coder, "points" => points }, socket) do
    {:ok, ticket} = TicketUpdater.update_estimate(%{ id: ticket_id, coder: coder, points: points })
    broadcast socket, "update", Ticket.to_map(ticket)
    {:noreply, socket}
  end

end
