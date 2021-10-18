defmodule Exapi.Users.Get do
  alias Exapi.{Repo, User}

  def by_id(id) do
    case Repo.get(User, id) do
      nil -> {:error, "error"}
      user -> {:ok, user}
    end
  end
end
