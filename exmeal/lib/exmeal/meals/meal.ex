defmodule Exmeal.Meals.Meal do
  use Ecto.Schema
  import Ecto.Changeset
  alias Exmeal.Users.User

  @required_params [:descricao, :date, :calorias]
  @derive {Jason.Encoder, only: @required_params++[:id]}

  schema "meals" do
    field :descricao, :string
    field :date, :naive_datetime
    field :calorias, :string

    belongs_to :user, User

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
  end

end
