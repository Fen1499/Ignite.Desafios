defmodule ExapiWeb.UsersView do
  use ExapiWeb, :view
  alias Exapi.User

  def render("create.json", _) do
    %{
      message: "Ok!"
    }
  end

  def render("token.json", %{user: %User{} = user}) do

  end
end
