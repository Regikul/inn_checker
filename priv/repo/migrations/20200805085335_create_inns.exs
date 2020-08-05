defmodule InnChecker.Repo.Migrations.CreateInns do
  use Ecto.Migration

  def change do
    create table(:inns) do
      add :value, :string
      add :valid, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:inns, [:value])
  end
end
