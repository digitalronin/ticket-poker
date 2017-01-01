defmodule TicketPoker.TeamView do
  use TicketPoker.Web, :view

  def coders_string(nil),     do: ""
  def coders_string(coders),  do: Enum.join(coders, "\n")
end
