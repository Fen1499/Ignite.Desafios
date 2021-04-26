defmodule Exmeal.Meals.Delete do
  alias Exmeal.{Repo, Meals.Meal}

  def call(id) do
    case Repo.get(Meal, id) do
      nil -> {:error, "Meal not found"}
      meal -> Repo.delete(meal)
    end
  end
end
