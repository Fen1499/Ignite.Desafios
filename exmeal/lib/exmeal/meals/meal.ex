defmodule Exmeal.Meals.Meal do
  use Ecto.Schema
  import Ecto.Changeset

  @required_params [:descricao, :data, :calorias]
  #@derive {Jason.Encoder, :all}

  schema "meals" do
    field :descricao, :string
    field :data, :naive_datetime
    field :calorias, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
  end

end
