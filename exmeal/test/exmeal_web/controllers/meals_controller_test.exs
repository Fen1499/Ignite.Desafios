defmodule ExmealWeb.MealControllerTest do
  use ExmealWeb.ConnCase, async: true
  alias Exmeal.Meals.{Create, Meal}
  import Exmeal.Factory

  describe "create/2" do
    test "when all parameters are valid, returns a new meal", %{conn: conn} do

      params = build(:meal_params, %{date: "2021-01-02"})
      response =
        conn
        |> post(Routes.meals_path(conn, :create, params))
        |> json_response(:created)

      assert %{"meal" => %{"calorias" => "5Kcal","descricao" => "frango"}, "message" => "Meal created"} = response
    end

    test "when there are invalid parameters, returns an error", %{conn: conn} do
      params = build(:meal_params, %{date: "2021-01-02", descricao: nil})
      response =
        conn
        |> post(Routes.meals_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{"message" => %{"descricao" => ["can't be blank"]}} = response
    end
  end

  describe "get/2" do
    test "when all parameters are valid, returns a meal", %{conn: conn} do
      {:ok, meal} =
        build(:meal_params)
        |> Create.call()

      %Meal{id: meal_id} = meal
      response =
        conn
        |> get(Routes.meals_path(conn, :show, meal_id))
        |> json_response(:ok)

      assert %{"meal" => %{"id" => meal_id}} = response
    end

    test "when there are invalid parameters, returns an error", %{conn: conn} do
      response =
        conn
        |> get(Routes.meals_path(conn, :show, 9999))
        |> json_response(:bad_request)

        assert %{"message" => "Meal not found"} = response
    end
  end
end
