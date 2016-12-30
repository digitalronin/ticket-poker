defmodule TicketPoker.TeamUpdater do
  alias TicketPoker.{
    TicketUpdater,
    Team,
    Repo
  }

  def create(params) do
    changeset = Team.changeset(%Team{}, pre_process(params))
    case Repo.insert(changeset) do
      {:ok, team} ->
        TicketUpdater.create(team, params)

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  def update(team, params) do
    changeset = Team.changeset(team, pre_process(params))
    case Repo.update(changeset) do
      {:ok, team} ->
        TicketUpdater.create(team, params)

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

end
