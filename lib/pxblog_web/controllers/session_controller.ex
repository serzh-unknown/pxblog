defmodule PxblogWeb.SessionController do
  @moduledoc false

  use PxblogWeb, :controller
  alias Pxblog.Accounts.User
  alias PxblogWeb.Router.Helpers
  require Logger

  def new(conn, _params) do
    render conn, "new.html", changeset: User.changeset(%User{}, %{})
  end

  plug :scrub_params, "user" when action in [:create]

  def create(conn, %{"user" => user_params}) do
    Pxblog.Repo.get_by(User, username: user_params["username"])
    |> sign_in(user_params["password"], conn)
  end

  defp sign_in(user, _password, conn) when is_nil(user) do
    conn
    |> put_flash(:error, "Invalid username/password!")
    |> redirect(to: Helpers.session_path(conn, :new))
  end

  defp sign_in(user, password, conn) do
    if Argon2.verify_pass(password, user.password_hash) do
      conn
      |> put_session(:current_user, %{id: user.id, username: user.username})
      |> put_flash(:info, "Sign in successful!")
      |> redirect(to: Helpers.page_path(conn, :home))
    else
      conn
      |> put_session(:current_user, nil)
      |> put_flash(:error, "Invalid username/password!")
      |> redirect(to: Helpers.session_path(conn, :new))
    end
  end

end
