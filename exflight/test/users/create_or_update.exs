defmodule Exflight.Users.CreateOrUpdateTest do
  use ExUnit.Case
  alias Exflight.Users.User
  alias Exflight.Users.Agent, as: UserAgent
  alias Exflight.Users.CreateOrUpdate

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})
      :ok
    end

    test "when all params are valid, saves the user" do
      params = %{name: "fen", email: "email@email.com", cpf: "123123123"}

      response = CreateOrUpdate.call(params)
      expected_response = {:ok, "User created or updated succesfully"}
      assert response == expected_response
    end

    test "when there are invalid params, return an error" do
      params = %{name: "fen", email: "email@email.com", cpf: 123123123}

      response = CreateOrUpdate.call(params)
      expected_response = {:error, "Invalid parameters"}
      assert response == expected_response
    end
  end
end
