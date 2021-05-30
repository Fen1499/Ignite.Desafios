defmodule Exmeal.Users.Create do
  alias Exmeal.Users.User
  alias Exmeal.Repo

  def call(params) do
    params
    |> User.changeset()
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
