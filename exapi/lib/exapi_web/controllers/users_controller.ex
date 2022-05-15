defmodule ExapiWeb.UsersController do
  use ExapiWeb, :controller
  alias ExapiWeb.Auth.Guardian
  alias Exapi.User

  def create(conn, params) do
    with {:ok, %User{} = user} <- Exapi.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end

  def login(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params, %{}) do
      conn
      |> put_status(:ok)
      |> render("token.json", token: token)
    end
  end

end
