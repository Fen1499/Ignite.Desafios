defmodule ExmealWeb.MealControllerTest do
  use ExmealWeb.ConnCase, async: true
  import Exmeal.Factory

  describe "create/2" do
    test "when all parameters are valid, returns a new meal", %{conn: conn} do

    params = build(:meal_params, %{date: "2021-01-02"})
    response =
      conn
      |> post(Routes.meals_path(conn, :create, params))
      |> json_response(:created)

    assert response == ""
    end
  end
end
