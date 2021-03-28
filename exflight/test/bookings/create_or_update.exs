defmodule Exflight.Bookings.CreateOrUpdateTest do
  use ExUnit.Case
  alias Exflight.Bookings.Booking
  alias Exflight.Bookings.Agent, as: BookingAgent
  alias Exflight.Bookings.CreateOrUpdate

  describe "call/1" do
    setup do
      BookingAgent.start_link(%{})
      :ok
    end

    test "when all params are valid, saves the user" do
      params = %{ano: 2021, mes: 03, dia:28, cidade_origem: "Orig", cidade_destino: "Dest", id_usuario: "0"}

      response = CreateOrUpdate.call(params)
      expected_response = {:ok, "Booking created or updated succesfully"}
      assert response == expected_response
    end

    test "when there are invalid params, return an error" do
      params = %{ano: 2021, mes: 03, dia:"28", cidade_origem: "Orig", cidade_destino: "Dest", id_usuario: "0"}

      response = CreateOrUpdate.call(params)
      expected_response = {:error, "Invalid parameters"}
      assert response == expected_response
    end
  end
end
