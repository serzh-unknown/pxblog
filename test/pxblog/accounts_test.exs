defmodule Pxblog.AccountsTest do
  use Pxblog.DataCase

  alias Pxblog.Accounts

  describe "users" do
    alias Pxblog.Accounts.User

    import Pxblog.AccountsFixtures

    @invalid_attrs %{email: nil, password_hash: nil, username: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()

      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()

      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{email: "some@ema.il", password: "some password", username: "some username"}

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.email == valid_attrs.email
      assert Argon2.verify_pass(valid_attrs.password, user.password_hash)
      assert user.username == valid_attrs.username
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{email: "some_updated@ema.il", password: "some updated password", username: "some updated username"}

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.email == update_attrs.email
      assert Argon2.verify_pass(update_attrs.password, user.password_hash)
      assert user.username == update_attrs.username
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()

      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()

      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()

      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
