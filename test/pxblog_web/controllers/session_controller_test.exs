defmodule PxblogWeb.SessionControllerTest do
  use PxblogWeb.ConnCase
  alias Pxblog.Accounts.User
  alias PxblogWeb.Router.Helpers
  alias Pxblog.Repo

  @user_attrs %{username: "test", password: "test", password_confirmation: "test", email: "e@ma.il"}

  setup do
    User.changeset(%User{}, @user_attrs)
    |> Repo.insert
    {:ok, conn: build_conn()}
  end

  test "shows the login form", %{conn: conn} do
    conn = get conn, Helpers.session_path(conn, :new)

    assert html_response(conn, 200) =~ "Login"
  end

  test "create a new user session for a valid user", %{conn: conn} do
    conn = post conn,
                Helpers.session_path(conn, :create),
                user: %{username: @user_attrs.username, password: @user_attrs.password}

    assert get_session(conn, :current_user)
    assert Phoenix.Flash.get(conn.assigns.flash, :info) == "Sign in successful!"
    assert redirected_to(conn) == Helpers.page_path(conn, :home)
  end

  test "does not create a session with a wrong password", %{conn: conn} do
    conn = post conn,
                Helpers.session_path(conn, :create),
                user: %{username: @user_attrs.username, password: "wrong"}

    refute get_session(conn, :current_user)
    assert Phoenix.Flash.get(conn.assigns.flash, :error) == "Invalid username/password!"
    assert redirected_to(conn) == Helpers.session_path(conn, :new)
  end

  test "does not create a session if user does not exists", %{conn: conn} do
    conn = post conn,
                Helpers.session_path(conn, :create),
                user: %{username: "wrong", password: @user_attrs.password}

    refute get_session(conn, :current_user)
    assert Phoenix.Flash.get(conn.assigns.flash, :error) == "Invalid username/password!"
    assert redirected_to(conn) == Helpers.session_path(conn, :new)
  end

  test "deletes the user session", %{conn: conn} do
    user = Repo.get_by(User, %{username: @user_attrs.username})

    conn = delete conn, Helpers.session_path(conn, :delete, user)

    refute get_session(conn, :current_user)
    assert Phoenix.Flash.get(conn.assigns.flash, :info) == "Signed out successfully!"
    assert redirected_to(conn) == Helpers.session_path(conn, :new)
  end

end
