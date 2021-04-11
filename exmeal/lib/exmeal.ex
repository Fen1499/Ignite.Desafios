defmodule Exmeal do
  defdelegate create_meal(params), to: Exmeal.Meals.Create, as: :call
end
