defmodule InnChecker.Administration do
  @moduledoc """
  The Administration context.
  """

  import Ecto.Query, warn: false
  alias InnChecker.Repo

  alias InnChecker.Administration.Role
  alias InnChecker.Administration.Support

  @doc """
  Returns the list of roles.

  ## Examples

      iex> list_roles()
      [%Role{}, ...]

  """
  def list_roles do
    Repo.all(Role)
  end

  @doc """
  Gets a single role.

  Raises `Ecto.NoResultsError` if the Role does not exist.

  ## Examples

      iex> get_role!(123)
      %Role{}

      iex> get_role!(456)
      ** (Ecto.NoResultsError)

  """
  def get_role!(id), do: Repo.get!(Role, id)

  @doc """
  Creates a role.

  ## Examples

      iex> create_role(%{field: value})
      {:ok, %Role{}}

      iex> create_role(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_role(<<_ :: binary>> = title) do
    %Role{title: title}
    |> Repo.insert()
  end
  def create_role(attrs) do
    %Role{}
    |> Role.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a role.

  ## Examples

      iex> update_role(roles, %{field: new_value})
      {:ok, %Role{}}

      iex> update_role(roles, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_role(%Role{} = roles, attrs) do
    roles
    |> Role.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a roles.

  ## Examples

      iex> delete_roles(roles)
      {:ok, %Role{}}

      iex> delete_roles(roles)
      {:error, %Ecto.Changeset{}}

  """
  def delete_role(%Role{} = roles) do
    Repo.delete(roles)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking roles changes.

  ## Examples

      iex> change_roles(roles)
      %Ecto.Changeset{data: %Role{}}

  """
  def change_role(%Role{} = role, attrs \\ %{}) do
    Role.changeset(role, attrs)
  end

  @doc """
  Returns the list of support.

  ## Examples

      iex> list_support()
      [%Support{}, ...]

  """
  def list_support do
    Repo.all(Support)
  end

  @doc """
  Gets a single support.

  Raises `Ecto.NoResultsError` if the Support does not exist.

  ## Examples

      iex> get_support!(123)
      %Support{}

      iex> get_support!(456)
      ** (Ecto.NoResultsError)

  """
  def get_support!(id), do: Repo.get!(Support, id)

  @doc """
  Creates a support.

  ## Examples

      iex> create_support(%{field: value})
      {:ok, %Support{}}

      iex> create_support(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_support(attrs \\ %{}) do
    %Support{}
    |> Support.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a support.

  ## Examples

      iex> update_support(support, %{field: new_value})
      {:ok, %Support{}}

      iex> update_support(support, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_support(%Support{} = support, attrs) do
    support
    |> Support.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a support.

  ## Examples

      iex> delete_support(support)
      {:ok, %Support{}}

      iex> delete_support(support)
      {:error, %Ecto.Changeset{}}

  """
  def delete_support(%Support{} = support) do
    Repo.delete(support)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking support changes.

  ## Examples

      iex> change_support(support)
      %Ecto.Changeset{data: %Support{}}

  """
  def change_support(%Support{} = support, attrs \\ %{}) do
    Support.changeset(support, attrs)
  end
end
