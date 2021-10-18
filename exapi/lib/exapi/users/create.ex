defmodule Exapi.Users.Create do
  alias Exapi.{Repo, User}

  def call(params) do
    User.changeset(params)
    |> Repo.insert()
  end
end
