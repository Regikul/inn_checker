defmodule InnChecker.UserContentTest do
  use InnChecker.DataCase

  alias InnChecker.UserContent

  describe "inns" do
    alias InnChecker.UserContent.Inn

    @valid_inn "500100732259"
    @invalid_inn "500100632259"
    @not_an_inn "50010hello!0632259"

    @valid_attrs %{valid: true, value: @valid_inn}
    @update_attrs %{valid: false, value: @invalid_inn}
    @invalid_attrs %{valid: nil, value: @not_an_inn}

    def inn_fixture(attrs \\ %{}) do
      {:ok, inn} =
        attrs
        |> Enum.into(@valid_attrs)
        |> UserContent.create_inn()

      inn
    end

    test "list_inns/0 returns all inns" do
      inn = inn_fixture()
      assert UserContent.list_inns() == [inn]
    end

    test "get_inn!/1 returns the inn with given id" do
      inn = inn_fixture()
      assert UserContent.get_inn!(inn.id) == inn
    end

    test "create_inn/1 with valid data creates a inn" do
      assert {:ok, %Inn{} = inn} = UserContent.create_inn(@valid_attrs)
      assert inn.valid == true
      assert inn.value == @valid_inn
    end

    test "create_inn/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserContent.create_inn(@invalid_attrs)
    end

    test "update_inn/2 with valid data updates the inn" do
      inn = inn_fixture()
      assert {:ok, %Inn{} = inn} = UserContent.update_inn(inn, @update_attrs)
      assert inn.valid == false
      assert inn.value == @invalid_inn
    end

    test "update_inn/2 with invalid data returns error changeset" do
      inn = inn_fixture()
      assert {:error, %Ecto.Changeset{}} = UserContent.update_inn(inn, @invalid_attrs)
      assert inn == UserContent.get_inn!(inn.id)
    end

    test "delete_inn/1 deletes the inn" do
      inn = inn_fixture()
      assert {:ok, %Inn{}} = UserContent.delete_inn(inn)
      assert_raise Ecto.NoResultsError, fn -> UserContent.get_inn!(inn.id) end
    end

    test "change_inn/1 returns a inn changeset" do
      inn = inn_fixture()
      assert %Ecto.Changeset{} = UserContent.change_inn(inn, %{value: @invalid_inn})
    end
  end
end
