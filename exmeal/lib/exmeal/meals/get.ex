defmodule Exmeal.Meals.Get do
  alias Exmeal.{Repo, Meals.Meal}

  def by_id(id) do
    case Repo.get(Meal, id) do
      nil -> {:error, "Meal not found"}
      meal -> {:ok, meal}
    end
  end
end
