defmodule InnChecker.AdministrationTest do
  use InnChecker.DataCase

  alias InnChecker.Administration

  describe "roles" do
    alias InnChecker.Administration.Role

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def roles_fixture(attrs \\ %{}) do
      {:ok, roles} =
        attrs
        |> Enum.into(@valid_attrs.title)
        |> Administration.create_role()

      roles
    end

    test "list_roles/0 returns all roles" do
      roles = roles_fixture()
      assert Administration.list_roles() == [roles]
    end

    test "get_role!/1 returns the role with given id" do
      roles = roles_fixture()
      assert Administration.get_role!(roles.id) == roles
    end

    test "create_role/1 with title creates a role" do
      assert {:ok, %Role{} = roles} = Administration.create_role(@valid_attrs.title)
      assert roles.title == "some title"
    end

    test "create_role/1 with valid data creates a role" do
      assert {:ok, %Role{} = roles} = Administration.create_role(@valid_attrs)
      assert roles.title == "some title"
    end

    test "create_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Administration.create_role(@invalid_attrs)
    end

    test "update_role/2 with valid data updates the role" do
      roles = roles_fixture()
      assert {:ok, %Role{} = roles} = Administration.update_role(roles, @update_attrs)
      assert roles.title == "some updated title"
    end

    test "update_role/2 with invalid data returns error changeset" do
      roles = roles_fixture()
      assert {:error, %Ecto.Changeset{}} = Administration.update_role(roles, @invalid_attrs)
      assert roles == Administration.get_role!(roles.id)
    end

    test "delete_role/1 deletes the roles" do
      roles = roles_fixture()
      assert {:ok, %Role{}} = Administration.delete_role(roles)
      assert_raise Ecto.NoResultsError, fn -> Administration.get_role!(roles.id) end
    end

    test "change_role/1 returns a roles changeset" do
      roles = roles_fixture()
      assert %Ecto.Changeset{} = Administration.change_role(roles)
    end
  end

  describe "support" do
    alias InnChecker.Administration.Support

    @valid_attrs %{login: "some login", name: "some name"}
    @update_attrs %{login: "some updated login", name: "some updated name"}
    @invalid_attrs %{login: nil, name: nil}

    def support_fixture(attrs \\ %{}) do
      {:ok, support} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Administration.create_support()

      support
    end

    test "list_support/0 returns all support" do
      support = support_fixture()
      assert Administration.list_support() == [support]
    end

    test "get_support!/1 returns the support with given id" do
      support = support_fixture()
      assert Administration.get_support!(support.id) == support
    end

    test "create_support/1 with valid data creates a support" do
      assert {:ok, %Support{} = support} = Administration.create_support(@valid_attrs)
      assert support.login == "some login"
      assert support.name == "some name"
    end

    test "create_support/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Administration.create_support(@invalid_attrs)
    end

    test "update_support/2 with valid data updates the support" do
      support = support_fixture()
      assert {:ok, %Support{} = support} = Administration.update_support(support, @update_attrs)
      assert support.login == "some updated login"
      assert support.name == "some updated name"
    end

    test "update_support/2 with invalid data returns error changeset" do
      support = support_fixture()
      assert {:error, %Ecto.Changeset{}} = Administration.update_support(support, @invalid_attrs)
      assert support == Administration.get_support!(support.id)
    end

    test "delete_support/1 deletes the support" do
      support = support_fixture()
      assert {:ok, %Support{}} = Administration.delete_support(support)
      assert_raise Ecto.NoResultsError, fn -> Administration.get_support!(support.id) end
    end

    test "change_support/1 returns a support changeset" do
      support = support_fixture()
      assert %Ecto.Changeset{} = Administration.change_support(support)
    end
  end
end
