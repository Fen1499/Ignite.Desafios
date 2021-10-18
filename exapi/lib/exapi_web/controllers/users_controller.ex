defmodule ExapiWeb.UsersController do
  use ExapiWeb, :controller
  alias Exapi.User

  def create(conn, params) do
    with {:ok, %User{} = user} <- Exapi.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end

  def show(conn, %{"id" =>  id}) do
    with {:ok, %User{} = user} <- Exapi.get_user_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("userjson", user: user)
    end
  end

end
