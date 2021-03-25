defmodule Exflight.Users.User do
  @keys [:id, :name, :email, :cpf]
  @enforce_keys @keys
  defstruct @keys

  #Todos os dados tem que ser string, se não, Invalid parameters!
  def build(name, email, cpf) when is_bitstring(cpf) and is_bitstring(email) and is_bitstring(cpf) do
    {
      :ok,
      %__MODULE__{
        id: UUID.uuid4(),
        name: name,
        email: email,
        cpf: cpf
      }
    }
  end
  def build(_name, _email, _cpf), do: {:error, "Invalid parameters!"}
end
