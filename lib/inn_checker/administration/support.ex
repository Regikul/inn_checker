defmodule InnChecker.Administration.Support do
  use Ecto.Schema
  import Ecto.Changeset

  schema "support" do
    field :login, :string
    field :password, :string, virtual: true
    field :name, :string

    belongs_to :role, InnChecker.Administration.Role

    timestamps()
  end

  @doc false
  def changeset(support, attrs) do
    support
    |> cast(attrs, [:name, :login, :role_id])
    |> validate_required([:name, :login])
    |> assoc_constraint(:role)
    |> validate_length(:name, min: 3, max: 30)
    |> validate_length(:login, min: 3, max: 30)
  end
end
