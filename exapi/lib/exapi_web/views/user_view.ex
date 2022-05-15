defmodule ExapiWeb.UsersView do
  use ExapiWeb, :view
  alias Exapi.User

  def render("create.json", %{user: %User{id: id}}) do
    %{
      message: "Ok!",
      id: id
    }
  end

  def render("token.json", %{token: token}) do
    %{
      message: "Ok!",
      token: token
    }
  end
end
