defmodule InnChecker.Repo.Migrations.CreateSupport do
  use Ecto.Migration

  def change do
    create table(:support) do
      add :name, :string
      add :login, :string
      add :role_id, references(:roles, on_delete: :nothing)

      timestamps()
    end

    create index(:support, [:role_id])
    create unique_index(:support, [:login])
  end
end
