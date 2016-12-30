defmodule TicketPoker.Repo.Migrations.CreateTicket do
  use Ecto.Migration

  def change do
    create table(:tickets, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :url, :string
      add :point_options, {:array, :integer}
      add :estimates, :map
      add :team_id, references(:teams, type: :binary_id, on_delete: :nothing)

      timestamps()
    end
    create index(:tickets, [:team_id])

  end
end
