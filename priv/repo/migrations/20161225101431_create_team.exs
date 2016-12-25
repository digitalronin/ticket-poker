defmodule PlanningPoker.Repo.Migrations.CreateTeam do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :string
      add :points, {:array, :integer}
      add :coders, {:array, :string}

      timestamps()
    end

  end
end
