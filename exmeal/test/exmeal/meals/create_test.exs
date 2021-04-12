defmodule Exmeal.Meals.CreateTest do
  use Exmeal.DataCase, async: true
  import Exmeal.Factory

  alias Exmeal.Meals.{Create, Meal}

  describe "call/1" do
    test "when all params are valid, returns a meal" do
      response =
        build(:meal_params)
        |> Create.call()

      assert {:ok, %Meal{id: _, descricao: "frango"}} = response
    end

    test "when there are invalid params, returns an error" do
      response =
        build(:meal_params, %{"date" => "vazio"})
        |> Create.call()

      assert {:error, _} = response
    end
  end
end
