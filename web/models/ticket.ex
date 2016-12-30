defmodule TicketPoker.Ticket do
  use TicketPoker.Web, :model

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "tickets" do
    field :url, :string
    field :point_options, {:array, :integer}
    field :estimates, :map
    belongs_to :team, TicketPoker.Team, type: :binary_id

    timestamps()
  end

  def new_ticket, do: %TicketPoker.Ticket{ estimates: %{} }

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:url, :point_options, :estimates])
    |> validate_required([:url, :point_options, :estimates])
  end

  # convert a ticket to a map, suitable for pushing down
  # a socket connection. currently, only point_options
  # and estimates are used in the react component, so
  # that's all we send
  def to_map(ticket) do
    %{
      point_options:  ticket.point_options,
      estimates:      ticket.estimates
    }
  end
end
