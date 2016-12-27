defmodule PlanningPoker.TicketUpdater do
  alias PlanningPoker.{Repo, Ticket}

  def estimation_complete?(ticket) do
    !has_zeroes?(ticket.estimates)
  end

  def create(team, %{ "new_ticket_url" => "" }), do: {:ok, team, nil}

  def create(team, %{ "new_ticket_url" => url }) do
    {:ok, ticket} = Ecto.build_assoc(team, :tickets, build_ticket_params(team, url))
                    |> Repo.insert
    {:ok, team, ticket}
  end

  def create(team, _), do: {:ok, team, nil}


  def update_estimate(%{ id: ticket_id, coder: coder, points: points}) do
    Repo.get(Ticket, ticket_id)
    |> update_estimate(coder, String.to_integer(points))
  end

  def update_estimate(ticket, coder, points) do
    new_estimates = Map.put(ticket.estimates, coder, points)
    Ecto.Changeset.change(ticket, %{ estimates: new_estimates }) |> Repo.update!
    t = %{ ticket | estimates: new_estimates }
    {:ok, t }
  end


  defp build_ticket_params(team, url) do
    %{
      team_id:        team.id,
      url:            url,
      point_options:  team.points,
      estimates:      build_initial_estimates(team.coders)
    }
  end

  defp build_initial_estimates(coders) do
    coders
    |> Enum.zip(Stream.cycle([0]))
    |> Enum.into(%{})
  end

  defp has_zeroes?(points_map) do
    points_map
    |> Map.to_list
    |> Enum.map(fn(t) -> elem(t, 1) end)
    |> Enum.member?(0)
  end

end
