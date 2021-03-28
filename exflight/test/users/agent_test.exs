defmodule Exflight.Users.AgentTest do
  use ExUnit.Case
  alias Exflight.Users.Agent, as: UserAgent
  alias Exflight.Users.User

  describe "save/1" do
    test "saves the user" do
      UserAgent.start_link(%{})
      {:ok, user} = User.build("Fen", "F@F.com", "123456")

      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    setup  do
      UserAgent.start_link(%{})
      :ok
    end

    test "when the user is found, returns the user" do
      {:ok, %User{id: id} = user} = User.build("Fen", "F@F.com", "123123123")
      UserAgent.save(user)

      response = UserAgent.get(id)
      expected_response = {:ok, %Exflight.Users.User{id: id, cpf: "123123123", email: "F@F.com", name: "Fen"}}
      assert response == expected_response

    end

    test "when the user is not found, returns an error" do
      response = UserAgent.get("1111")
      expected_response = {:error, "User not found"}
      assert response == expected_response
    end
  end

end
