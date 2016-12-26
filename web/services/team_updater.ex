defmodule PlanningPoker.TeamUpdater do
  alias PlanningPoker.{
    Team,
    Repo
  }

  def create(params) do
    changeset = Team.changeset(%Team{}, pre_process(params))
    case Repo.insert(changeset) do
      {:ok, team} ->
        create_ticket(team, params)

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  def update(team, params) do
    changeset = Team.changeset(team, pre_process(params))
    case Repo.update(changeset) do
      {:ok, team} ->
        create_ticket(team, params)

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  defp pre_process(team_params) do
    %{
      "name"   => team_params["name"],
      "points" => Team.pre_process_points(team_params["points_string"]),
      "coders" => Team.pre_process_coders(team_params["coders"])
    }
  end

  defp create_ticket(team, %{ "new_ticket_url" => "" }), do: {:ok, team, nil}

  defp create_ticket(team, %{ "new_ticket_url" => url }) do
    {:ok, ticket} = Ecto.build_assoc(team, :tickets, build_ticket_params(team, url))
                    |> Repo.insert
    {:ok, team, ticket}
  end

  defp create_ticket(team, _), do: {:ok, team, nil}

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

end
