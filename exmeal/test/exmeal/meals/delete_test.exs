defmodule Exmeal.Meals.DeleteTest do
  use Exmeal.DataCase, async: true
  import Exmeal.Factory

  alias Exmeal.Meals.{Create, Delete, Meal}

  describe "call/1" do
    test "when all params are valid, returns a meal" do
      {:ok, meal} =
        build(:meal_params)
        |> Create.call()

      %Meal{id: meal_id} = meal
      response = Delete.call(meal_id)

      assert {:ok, _} = response
    end

    test "when there are invalid params, returns an error" do
      response = Delete.call("999")

      assert {:error, _} = response
    end
  end
end
