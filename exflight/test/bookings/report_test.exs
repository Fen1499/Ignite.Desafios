defmodule Exflight.Bookings.BookingTest do
  use ExUnit.Case
  alias Exflight.Bookings.Agent, as: BookingAgent
  alias Exflight.Bookings.{Booking, Report}

  describe "create/1" do
    test "create_the_report_file" do
      Exflight.start_agents()

      #Usando save, assim eu não preciso de um usuario_id valido
      {:ok, %Booking{id: id1} = booking} = Booking.build(2021, 03, 28,  "Orig",  "Dest",  "0")
      BookingAgent.save(booking)
      {:ok, %Booking{id: id2} = booking} = Booking.build(2021, 03, 29,  "Orig",  "Dest",  "0")
      BookingAgent.save(booking)
      {:ok, %Booking{id: id3} = booking} = Booking.build(2021, 03, 30,  "Orig",  "Dest",  "0")
      BookingAgent.save(booking)

      Report.create("2019-03-20", "2021-03-29", "report_test.csv")

      {:ok, response} = File.read("report_test.csv")

      expected_response = "#{id2},Orig,Dest,2021-03-29 00:00:00\n#{id1},Orig,Dest,2021-03-28 00:00:00\n"

      assert response == expected_response


    end
  end
end
