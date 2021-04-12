defmodule Exmeal.Meals.Create do
  alias Exmeal.Meals.Meal
  alias Exmeal.Repo

  def call(params) do
    params
    |> Meal.changeset()
    |> Repo.insert()
    |> handle_result()
  end

  defp handle_result({status, _} = result) do
    case status do
      :ok -> result
      :error -> result
    end
  end

end
