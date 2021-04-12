defmodule Exmeal.Factory do
  use ExMachina.Ecto, repo: Exmeal.Repo
  #alias Exmeal.Meals.Meal

  def meal_params_factory do
    {:ok, date} = Date.new(2021, 1, 1)
    {:ok, time} = Time.new(0, 0, 30)
    {:ok, datetime} =  NaiveDateTime.new(date, time)
    %{
      "descricao" => "frango",
      "date" => datetime,
      "calorias" => "5Kcal"
    }
  end
end
