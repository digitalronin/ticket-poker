defmodule PlanningPoker.TicketController do
  use PlanningPoker.Web, :controller

  alias PlanningPoker.Ticket

  def index(conn, _params) do
    tickets = Repo.all(Ticket)
    render(conn, "index.html", tickets: tickets)
  end

  def new(conn, _params) do
    changeset = Ticket.changeset(%Ticket{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"ticket" => ticket_params}) do
    changeset = Ticket.changeset(%Ticket{}, ticket_params)

    case Repo.insert(changeset) do
      {:ok, _ticket} ->
        conn
        |> put_flash(:info, "Ticket created successfully.")
        |> redirect(to: ticket_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    ticket = Repo.get!(Ticket, id)
    render(conn, "show.html", ticket: ticket)
  end

  def edit(conn, %{"id" => id}) do
    ticket = Repo.get!(Ticket, id)
    changeset = Ticket.changeset(ticket)
    render(conn, "edit.html", ticket: ticket, changeset: changeset)
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

  def delete(conn, %{"id" => id}) do
    ticket = Repo.get!(Ticket, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(ticket)

    conn
    |> put_flash(:info, "Ticket deleted successfully.")
    |> redirect(to: ticket_path(conn, :index))
  end
end
