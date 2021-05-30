defmodule Exmeal.Factory do
  use ExMachina.Ecto, repo: Exmeal.Repo
  alias Exmeal.{Meals.Meal, Users.User}

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

  def meal_factory do
    {:ok, date} = Date.new(2021, 1, 1)
    {:ok, time} = Time.new(0, 0, 30)
    {:ok, datetime} =  NaiveDateTime.new(date, time)
    %Meal{
      id: 1,
      descricao: "frango",
      date: datetime,
      calorias: "5Kcal"
    }
  end

  def users_params_factory do
    %{
      name: "xFen",
      email: "fen@fen.com",
      cpf: "12345678900"
    }
  end

  def user_factory do
    %User{
      name: "xFen",
      email: "fen@fen.com",
      cpf: "12345678900",
      id: "99999"
    }
  end
end
