defmodule Exapi do
  defdelegate create_user(params), to: Exapi.Users.Create, as: :call
  defdelegate get_user_by_id(id), to: Exapi.Users.Get, as: :by_id
end
