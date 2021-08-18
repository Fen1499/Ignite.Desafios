defmodule Exapi.GitApi.ClientTest do
  use ExUnit.Case, async: true
  alias Exapi.GitApi.Client

  describe "get_user_info/1" do
    setup do
      bypass = Bypass.open()
      {:ok, bypass: bypass}
    end

    test "when there is a valid user returns an user", %{bypass: bypass} do
      url = endpoint_url(bypass.port)
      username = "fen1499"
      body = ~s(
        [{
          "description": "Automato de pilha nao deterministico",
          "extra_field_for_test_purposes": true
        }]
      )

      Bypass.expect(bypass, "GET", "/users/#{username}/repos", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(200, body)
      end)

      response = Client.get_user_info(url, username)

      expected_response = {:ok,
      [%{
        "description" => "Automato de pilha nao deterministico",
        "extra_field_for_test_purposes" => true
      }]}

      assert response == expected_response
    end

    test "when there is an invalid user returns not_found", %{bypass: bypass} do
      url = endpoint_url(bypass.port)
      username = "fen1499"

      Bypass.expect(bypass, "GET", "/users/#{username}/repos", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(404, "")
      end)

      response = Client.get_user_info(url, username)

      assert {:error, %Tesla.Env{status: 404}} = response
    end

    defp endpoint_url(porta), do: "http://localhost:#{porta}"
  end
end
