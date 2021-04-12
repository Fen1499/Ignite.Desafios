defmodule ExmealWeb.MealsController do
  use ExmealWeb, :controller
  alias Exmeal.Meals.{Create, Meal}
  alias ExmealWeb.FallbackController

  action_fallback FallbackController
  def create(conn, params) do
    with {:ok, %Meal{} = meal} <- Create.call(treat_request(params)) do
      conn
      |> put_status(:created)
      |> render("create.json", meal: meal)
    end
  end

  defp treat_request(%{} = params) do
    {:ok, datetime} = NaiveDateTime.new(2033, 1, 1, 0, 0, 30)
    %{
      descricao: params["descricao"],
      calorias: params["calorias"],
      date: datetime
    }
  end
end
