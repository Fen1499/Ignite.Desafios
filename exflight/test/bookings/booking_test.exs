defmodule Exflight.Bookings.BookingsTest do
  use ExUnit.Case
  alias Exflight.Bookings.Booking

  describe "build/3" do
    test "when all params are valid returns the booking" do
      response = Booking.build(2021, 03, 27, "Orig", "Dest", "0")
      {:ok , %Booking{id: id}} = response

      {:ok, data} = Date.new(2021, 03, 27)
      {:ok, hora} = Time.new(0, 0, 0)
      {:ok, time} = NaiveDateTime.new(data, hora)
      expected_response = {:ok,
        %Booking{
          id: id,
          data_completa: time,
          cidade_origem: "Orig",
          cidade_destino: "Dest",
          id_usuario: "0"
          }
        }

      assert response == expected_response
    end

    test "when there are invalid parameters returns an error" do
      response = Booking.build("dia", 03, 27, "Orig", "Dest", "0")
      expected_response = {:error, "Invalid parameters!"}

      assert response == expected_response
    end
  end

end
