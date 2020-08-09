defmodule InnChecker.Repo.Migrations.AddSourceIpToInn do
  use Ecto.Migration

  def change do
    alter table(:inns) do
      add :source_ip, :string, default: "0.0.0.0", null: false
    end
  end
end
