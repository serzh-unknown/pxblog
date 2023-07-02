defmodule PxblogWeb.LayoutsTest do
  use PxblogWeb.ConnCase, async: true
  alias PxblogWeb.Layouts
  alias Pxblog.Accounts.User
  alias PxblogWeb.Router.Helpers
  alias Pxblog.Repo

  setup do
    User.changeset(%User{}, %{username: "test", password: "test", password_confirmation: "test", email: "e@ma.il"})
    |> Repo.insert
    {:ok, conn: build_conn()}
  end

  test "current_user returns the user in session", %{conn: conn} do
    conn = post conn, Helpers.session_path(conn, :create), user: %{username: "test", password: "test"}

    assert Layouts.current_user(conn)
  end

  test "current_user returns nothing if there is no user in the sessions", %{conn: conn} do
    user = Repo.get_by(User, %{username: "test"})

    conn = delete conn, Helpers.session_path(conn, :delete, user)

    refute Layouts.current_user(conn)
  end
end