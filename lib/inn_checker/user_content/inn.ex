defmodule InnChecker.UserContent.Inn do
  use Ecto.Schema
  import Ecto.Changeset

  alias InnChecker.InnValidator

  schema "inns" do
    field :value, :string, null: false
    field :valid, :boolean, default: false, null: false
    field :source_ip, :string, null: false

    timestamps()
  end

  @doc false
  def changeset(inn, attrs) do
    inn
    |> cast(attrs, [:value, :source_ip])
    |> validate_required([:value])
    # do we need this strictness?
    |> validate_inn_length(:value)
    |> validate_inn_digits(:value)
    |> unique_constraint(:value)
    |> put_inn_validation()
  end

  def validate_inn_digits(changeset, field) do
    validate_change changeset, field, fn _, inn ->
      if InnValidator.valid_digits_range?(inn) do
        []
      else
        [{field, "should contain only digits"}]
      end
    end
  end

  def validate_inn_length(changeset, field) do
    validate_change changeset, field, fn _, inn ->
      if InnValidator.valid_length?(inn) do
        []
      else
        [{field, "should be 10 or 12 digits long"}]
      end
    end
  end

  def put_inn_validation(changeset) do
    inn = get_change(changeset, :value)
    validated = InnValidator.valid?(inn)
    put_change(changeset, :valid, validated)
  end
end
