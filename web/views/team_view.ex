defmodule PlanningPoker.TeamView do
  use PlanningPoker.Web, :view

  def coders_string(nil),     do: ""
  def coders_string(coders),  do: Enum.join(coders, "\n")
end
