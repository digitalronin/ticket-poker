defmodule PlanningPoker.TicketView do
  use PlanningPoker.Web, :view

  alias PlanningPoker.TicketUpdater

  def estimation_complete?(ticket), do: TicketUpdater.estimation_complete?(ticket)
end
