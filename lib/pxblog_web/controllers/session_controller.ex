defmodule PxblogWeb.SessionController do
  @moduledoc false

  use PxblogWeb, :controller
  alias Pxblog.Accounts.User
  alias PxblogWeb.Router.Helpers
  require Logger

  @doc """
  Login form
  """

  def new(conn, _params) do
    render conn, "new.html", %{changeset: User.changeset(%User{}, %{}), layout: false}
  end

  @doc """
  Login action
  """

  plug :scrub_params, "user" when action in [:create]

  def create(conn, %{"user" => %{"username" => username, "password" => password}})
    when not is_nil(username) and not is_nil(password) do
    Pxblog.Repo.get_by(User, username: username)
    |> sign_in(password, conn)
  end

  @doc """
  Login failed action (username or/and password is empty)
  """

  def create(conn, _) do
    failed_login(conn)
  end

  defp failed_login(conn) do
    Argon2.no_user_verify()
    conn
    |> put_session(:current_user, nil)
    |> put_flash(:error, "Invalid username/password!")
    |> redirect(to: Helpers.session_path(conn, :new))
    |> halt()
  end

  defp sign_in(user, _password, conn) when is_nil(user) do
    failed_login(conn)
  end

  defp sign_in(user, password, conn) do
    if Argon2.verify_pass(password, user.password_hash) do
      conn
      |> put_session(:current_user, %{id: user.id, username: user.username})
      |> put_flash(:info, "Sign in successful!")
      |> redirect(to: Helpers.page_path(conn, :home))
    else
      failed_login(conn)
    end
  end

  @doc """
  Logout action
  """

  def delete(conn, _params) do
    conn
    |> delete_session(:current_user)
    |> put_flash(:info, "Signed out successfully!")
    |> redirect(to: Helpers.session_path(conn, :new))
  end

end
