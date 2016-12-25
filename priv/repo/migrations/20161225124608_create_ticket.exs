defmodule PlanningPoker.Repo.Migrations.CreateTicket do
  use Ecto.Migration

  def change do
    create table(:tickets) do
      add :url, :string
      add :point_options, {:array, :integer}
      add :estimates, :map

      timestamps()
    end

  end
end
