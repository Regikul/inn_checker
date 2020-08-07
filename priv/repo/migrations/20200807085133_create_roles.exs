defmodule InnChecker.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :title, :string

      timestamps()
    end

    create unique_index(:roles, [:title])

  end
end
