defmodule Exmeal.Users.CreateTest do
  use Exmeal.DataCase, async: true
  alias Exmeal.Users.{User, Create}

  import Exmeal.Factory

  describe "Create User" do
    test "when all params are valid, returns the user" do
      user_params = build(:users_params)

      {:ok, response} = Create.call(user_params)

      id = response.id

      assert %User{
               cpf: "12345678900",
               email: "fen@fen.com",
               name: "xFen",
               id: ^id
             } = response
    end

    test "when there are invalid params, returns an error" do
      params = %{
        cpf: 12_345_678_900,
        email: "Jpbanana.com"
      }

      response = Create.call(params)

      assert {:error, _} = response
    end
  end
end
