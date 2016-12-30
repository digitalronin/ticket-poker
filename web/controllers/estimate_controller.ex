defmodule TicketPoker.EstimateController do
  use TicketPoker.Web, :controller

  alias TicketPoker.TicketUpdater

  def update(conn, %{"ticket_id" => ticket_id, "coder" => coder, "points" => points }) do
    {:ok, ticket} = TicketUpdater.update_estimate(%{ id: ticket_id, coder: coder, points: points })
    redirect(conn, to: ticket_path(conn, :show, ticket))
  end
end
