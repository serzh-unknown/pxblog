defmodule Pxblog.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pxblog.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "user@email.com",
        password: "password",
        username: "username"
      })
      |> Pxblog.Accounts.create_user()

    user
  end
end
