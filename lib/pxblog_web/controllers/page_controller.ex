defmodule PxblogWeb.PageController do
  use PxblogWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
