defmodule Exmeal.Users.Delete do
  alias Exmeal.{Repo, Users.User}

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, "User not found"}
      user -> Repo.delete(user)
    end
  end
end
