defmodule PlanningPoker.Team do
  use PlanningPoker.Web, :model

  schema "teams" do
    field :name, :string
    field :points, {:array, :integer}
    field :coders, {:array, :string}

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :points, :coders])
    |> validate_required([:name, :points, :coders])
  end
end
