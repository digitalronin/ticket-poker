defmodule TicketPoker.TeamController do
  use TicketPoker.Web, :controller

  alias TicketPoker.{ Team, TeamUpdater }

  @default_points [1, 2, 3, 5, 8, 13]

  def new(conn, _params) do
    changeset = Team.changeset(%Team{ points: @default_points })
    render(conn, "new.html", changeset: changeset, team: %Team{})
  end

  def create(conn, %{"team" => team_params}) do
    case TeamUpdater.create(team_params) do
      {:ok, team, ticket} ->
        case ticket do
          nil ->
            conn
            |> put_flash(:info, "Team created successfully.")
            |> redirect(to: team_path(conn, :show, team))

          _ ->
            conn
            |> redirect(to: ticket_path(conn, :show, ticket))
        end

      {:error, changeset} ->
        render(conn, "new.html", team: %Team{}, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    team = find_team(id)
    changeset = Team.changeset(team)

    render(conn, "show.html", title: team.name, team: team, changeset: changeset)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = find_team(id)

    case TeamUpdater.update(team, team_params) do
      {:ok, team, ticket} ->
        case ticket do
          nil ->
            conn
            |> put_flash(:info, "Team updated successfully.")
            |> redirect(to: team_path(conn, :show, team))

          _ ->
            conn
            |> redirect(to: ticket_path(conn, :show, ticket))
        end

      {:error, changeset} ->
        render(conn, "show.html", team: team, changeset: changeset)
    end
  end

  defp find_team(id), do: Repo.get!(Team, id)

end
