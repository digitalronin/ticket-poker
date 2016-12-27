defmodule PlanningPoker.TicketController do
  use PlanningPoker.Web, :controller

  alias PlanningPoker.Ticket

  def show(conn, %{"id" => id}) do
    ticket = Repo.get!(Ticket, id)
    render(conn, "show.html", ticket: ticket)
  end

  def update(conn, %{"id" => id, "ticket" => ticket_params}) do
    ticket = Repo.get!(Ticket, id)
    changeset = Ticket.changeset(ticket, ticket_params)

    case Repo.update(changeset) do
      {:ok, ticket} ->
        conn
        |> put_flash(:info, "Ticket updated successfully.")
        |> redirect(to: ticket_path(conn, :show, ticket))
      {:error, changeset} ->
        render(conn, "edit.html", ticket: ticket, changeset: changeset)
    end
  end

end
