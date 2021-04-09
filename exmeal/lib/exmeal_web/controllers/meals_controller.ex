defmodule ExmealWeb.MealsController do
  use ExmealWeb, :controller
  alias Exmeal.Meals.Meal
  alias ExmealWeb.FallbackController

  action_fallback FallbackController
  def create(conn, params) do
    with {:ok, %Meal{} = meal} <- Exmeal.Meals.Create.call(params) do
      conn
      |> put_status(:created)
      |> render("create.json", meal: meal)
    end
  end

end
