defmodule Exmeal.Users.Get do
  alias Exmeal.{Repo, Users.User}

  def by_id(id) do
    case Repo.get(User, id) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end
