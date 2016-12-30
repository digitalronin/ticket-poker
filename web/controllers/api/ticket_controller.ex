defmodule TicketPoker.API.TicketController do
  use TicketPoker.Web, :controller

  alias TicketPoker.Ticket

  def show(conn, %{"id" => id}) do
    ticket = Repo.get!(Ticket, id)
    render(conn, "show.json", ticket: ticket)
  end

  def update(conn, %{"id" => id, "ticket" => ticket_params}) do
    ticket = Repo.get!(Ticket, id)
    changeset = Ticket.changeset(ticket, ticket_params)

    case Repo.update(changeset) do
      {:ok, ticket} ->
        render(conn, "show.json", ticket: ticket)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(TicketPoker.ChangesetView, "error.json", changeset: changeset)
    end
  end

end
