defmodule Exflight.Users.CreateOrUpdate do
  alias Exflight.Users.User
  alias Exflight.Users.Agent, as: UserAgent

  def call(%{name: name, email: email, cpf: cpf}) do
    case User.build(name, email, cpf) do
      {:ok, %User{id: id} = user} ->
        UserAgent.save(user)
        {:ok, id}

      {:error, _reason} = err -> err
    end
  end
end
