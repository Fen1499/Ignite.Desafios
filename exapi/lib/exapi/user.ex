defmodule Exapi.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}
  @required_params [:password]

  schema "users" do
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  def changeset(params) do
  %__MODULE__{}
  |> cast(params, @required_params)
  |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end
end
