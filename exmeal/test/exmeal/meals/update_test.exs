defmodule Exmeal.Meals.UpdateTest do
  use Exmeal.DataCase, async: true
  import Exmeal.Factory

  alias Exmeal.Meals.{Create, Update, Meal}

  describe "call/1" do
    test "when all params are valid, returns a meal" do
      {:ok, meal} =
        build(:meal_params)
        |> Create.call()

      %Meal{id: meal_id, date: meal_date} = meal
      new_meal = %{
        "id" => meal_id,
        "date" => meal_date,
        "descricao" => "Alterado",
        "calorias" => "0"
      }
      response = Update.call(new_meal)

      assert {:ok, _} = response
    end

    test "when there are invalid params, returns an error" do

      response = Update.call(%{"id" => 0})

      assert {:error, _} = response
    end
  end
end
