defmodule PlanningPoker.Repo.Migrations.CreateTeam do
  use Ecto.Migration

  def change do
    create table(:teams, primary_key: false) do
      add :id,     :binary_id, primary_key: true
      add :name,   :string
      add :points, {:array, :integer}
      add :coders, {:array, :string}

      timestamps()
    end

  end
end
