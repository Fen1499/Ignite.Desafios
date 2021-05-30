defmodule ExmealWeb.UsersController do
  use ExmealWeb, :controller
  alias Exmeal.Users.{Create, Delete, Get, Update, User}
  alias ExmealWeb.FallbackController

  action_fallback FallbackController
  def create(conn, params) do
    with {:ok, %User{} = user} <- Create.call(treat_request(params)) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Get.by_id(id) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end

  def delete(conn, %{"id" =>  id}) do
    with {:ok, %User{}} <- Delete.call(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def update(conn, params) do
    with {:ok, %User{} = user} <- Update.call(params) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end

  defp treat_request(%{} = params) do
    {:ok, datetime} = NaiveDateTime.new(2033, 1, 1, 0, 0, 30) #talvez isso não deveria estar aqui ;-;
    %{
      descricao: params["descricao"],
      calorias: params["calorias"],
      date: datetime
    }
  end
end
