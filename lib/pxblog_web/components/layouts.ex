defmodule PxblogWeb.Layouts do
  use PxblogWeb, :html
  alias PxblogWeb.Router.Helpers

  embed_templates "layouts/*"

  def current_user(conn) do
    Plug.Conn.get_session(conn, :current_user)
  end

end
