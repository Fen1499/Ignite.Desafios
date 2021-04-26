defmodule ExmealWeb.MealsViewTest do
  use ExmealWeb.ConnCase, async: true
  alias ExmealWeb.MealsView

  import Phoenix.View
  import Exmeal.Factory

  test "render create.json" do
    meal = build(:meal)
    response = render(MealsView, "create.json", meal: meal)
    assert %{meal: _, message: "Meal created"} = response

  end

  test "render meal.json" do
    meal = build(:meal)
    response = render(MealsView, "meal.json", meal: meal)
    assert %{meal: _} = response

  end
end
