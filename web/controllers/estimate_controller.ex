defmodule PlanningPoker.EstimateController do
  use PlanningPoker.Web, :controller

  def show(conn, params) do
    IO.inspect params
    render(conn, "show.html", {})
  end
end
