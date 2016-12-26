defmodule PlanningPoker.EstimateController do
  use PlanningPoker.Web, :controller

  def show(conn, %{ "id" => coder , "ticket_id" => ticket_id}) do
    IO.puts "ticket show ticket_id #{ticket_id}, coder: #{coder}"
    render(conn, "show.html", %{})
  end
end
