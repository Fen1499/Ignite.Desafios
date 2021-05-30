defmodule Exmeal.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rockelivery.Meals.Meal

  @required_params [:nome, :cpf, :email]
  @derive {Jason.Encoder, only: @required_params++[:id]}

  schema "users" do
    field :nome, :string
    field :cpf, :string
    field :email, :string

    has_many :meal, Meal

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> unique_constraint([:cpf])
  end
end
