defmodule PlanningPoker.TeamController do
  use PlanningPoker.Web, :controller

  alias PlanningPoker.Team

  def index(conn, _params) do
    teams = Repo.all(Team)
    render(conn, "index.html", teams: teams)
  end

  def new(conn, _params) do
    changeset = Team.changeset(%Team{})
    render(conn, "new.html", changeset: changeset, team: %Team{})
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
        render(conn, "new.html", team: %Team{}, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    render(conn, "show.html", team: find_team(id))
  end

  def edit(conn, %{"id" => id}) do
    team = find_team(id)
    changeset = Team.changeset(team)

    render(conn, "edit.html", team: team, changeset: changeset)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = find_team(id)
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
    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(find_team(id))

    conn
    |> put_flash(:info, "Team deleted successfully.")
    |> redirect(to: team_path(conn, :index))
  end

  defp find_team(id), do: Repo.get!(Team, id)

  defp pre_process(team_params) do
    %{
      "name"   => team_params["name"],
      "points" => Team.pre_process_points(team_params["points_string"]),
      "coders" => Team.pre_process_coders(team_params["coders"])
    }
  end
end
