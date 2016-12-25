defmodule PlanningPoker.TeamController do
  use PlanningPoker.Web, :controller

  alias PlanningPoker.Team

  def index(conn, _params) do
    teams = Repo.all(Team)
    render(conn, "index.html", teams: teams)
  end

  def new(conn, _params) do
    changeset = Team.changeset(%Team{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"team" => team_params}) do
    params = pre_process team_params
    changeset = Team.changeset(%Team{}, params)

    case Repo.insert(changeset) do
      {:ok, _team} ->
        conn
        |> put_flash(:info, "Team created successfully.")
        |> redirect(to: team_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    team = Repo.get!(Team, id)
    render(conn, "show.html", team: team)
  end

  def edit(conn, %{"id" => id}) do
    team = Repo.get!(Team, id)
    changeset = Team.changeset(team)

    render(conn, "edit.html", team: team, changeset: changeset)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = Repo.get!(Team, id)
    params = pre_process team_params
    changeset = Team.changeset(team, params)

    case Repo.update(changeset) do
      {:ok, team} ->
        conn
        |> put_flash(:info, "Team updated successfully.")
        |> redirect(to: team_path(conn, :show, team))
      {:error, changeset} ->
        render(conn, "edit.html", team: team, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = Repo.get!(Team, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(team)

    conn
    |> put_flash(:info, "Team deleted successfully.")
    |> redirect(to: team_path(conn, :index))
  end

  defp pre_process(team_params) do
    %{
      "name"   => team_params["name"],
      "points" => pre_process_points(team_params["points_string"]),
      "coders" => pre_process_coders(team_params["coders"])
    }
  end

  defp pre_process_points(nil), do: []
  defp pre_process_points(""), do: []

  defp pre_process_points(str) do
    str
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
  end

  defp pre_process_coders(str) when is_binary(str) do
    str
    |> String.split("\n")
  end

  defp pre_process_coders(arr), do: arr

end
