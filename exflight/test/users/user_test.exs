defmodule Exflight.Users.UsersTest do
  use ExUnit.Case
  alias Exflight.Users.User

  describe "build/3" do
    test "when all params are valid returns the user" do
      response = User.build("Fen", "F@F.com", "123456")
      {:ok , %User{id: id}} = response
      expected_response = {:ok, %User{name: "Fen", cpf: "123456", email: "F@F.com", id: id} }

      assert response == expected_response
    end

    test "when there are invalid parameters returns an error" do
      response = User.build("Fen", "F@F.com", 123123123)
      expected_response = {:error, "Invalid parameters!"}

      assert response == expected_response
    end
  end

end
