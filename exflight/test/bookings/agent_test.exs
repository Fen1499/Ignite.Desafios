defmodule Exflight.Bookings.AgentTest do
  use ExUnit.Case
  alias Exflight.Bookings.Agent, as: BookingAgent
  alias Exflight.Bookings.Booking

  describe "save/1" do
    test "saves the booking" do
      BookingAgent.start_link(%{})
      {:ok, booking} = Booking.build(2021, 03, 28,  "Orig",  "Dest",  "0")

      assert BookingAgent.save(booking) == :ok
    end
  end

  describe "get/1" do
    setup  do
      BookingAgent.start_link(%{})
      :ok
    end

    test "when the booking is found, returns the booking" do
      {:ok, %Booking{id: id} = booking} = Booking.build(2021, 03, 28,  "Orig",  "Dest",  "0")
      BookingAgent.save(booking)

      response = BookingAgent.get(id)
      expected_response = {:ok, %Exflight.Bookings.Booking{cidade_destino: "Dest", cidade_origem: "Orig", data_completa: ~N[2021-03-28 00:00:00], id: id, id_usuario: "0"}}
      assert response == expected_response

    end

    test "when the booking is not found, returns an error" do
      response = BookingAgent.get("1111")
      expected_response = {:error, "Booking not found"}
      assert response == expected_response
    end
  end

end
