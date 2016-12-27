defmodule PlanningPoker.EstimateController do
  use PlanningPoker.Web, :controller

  alias PlanningPoker.TicketUpdater

  def update(conn, %{"ticket_id" => ticket_id, "coder" => coder, "points" => points }) do
    {:ok, ticket} = TicketUpdater.update_estimate(%{ id: ticket_id, coder: coder, points: points })
    redirect(conn, to: ticket_path(conn, :edit, ticket))
  end
end
