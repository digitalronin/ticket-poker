defmodule PlanningPoker.Ticket do
  use PlanningPoker.Web, :model

  schema "tickets" do
    field :url, :string
    field :point_options, {:array, :integer}
    field :estimates, :map
    belongs_to :team, PlanningPoker.Team

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:url, :point_options, :estimates])
    |> validate_required([:url, :point_options, :estimates])
  end
end
