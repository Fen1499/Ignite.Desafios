defmodule Exmeal.Users.Update do
  alias Exmeal.{Repo, Users.User}



  def call(%{"id" => id} = params) do
    case Repo.get(User, id) do
      nil -> {:error, "User not found"}
      user -> do_update(user, params)
    end
  end

  defp do_update(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end
end
