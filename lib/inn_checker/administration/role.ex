defmodule InnChecker.Administration.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> unique_constraint(:title)
  end
end
