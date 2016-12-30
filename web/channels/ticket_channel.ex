defmodule TicketPoker.TicketChannel do
  use TicketPoker.Web, :channel

  def join("ticket:" <> _ticket_id, _payload, socket) do
    {:ok, socket}
  end

  # The only thing this socket does is re-broadcast any 'update'
  # messages that come in, so that all connected clients know
  # they should re-fetch the currently displayed ticket's data
  def handle_in("update", _payload, socket) do
    broadcast socket, "update", %{}
    {:noreply, socket}
  end
end
