defmodule PlanningPoker.Team do
  use PlanningPoker.Web, :model

  schema "teams" do
    field :name, :string
    field :points, {:array, :integer}
    field :points_string, :string, virtual: true
    field :coders, {:array, :string}

    timestamps()
  end

  def pre_process_points(nil), do: []
  def pre_process_points(""), do: []

  def pre_process_points(str) do
    str
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
  end

  def pre_process_coders(str) when is_binary(str) do
    str
    |> String.split("\n")
  end

  def pre_process_coders(arr), do: arr


  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :points, :points_string, :coders])
    |> validate_required([:name, :points, :coders])
    |> build_points_string
  end

  defp build_points_string(changeset) do
    put_change(changeset, :points_string, points_string(changeset.data))
  end

  defp points_string(%{ points: nil }), do: ""

  defp points_string(%{ points: points }), do: Enum.join(points, " ")

end
