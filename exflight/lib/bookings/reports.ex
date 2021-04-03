defmodule Exflight.Bookings.Report do
  alias Exflight.Bookings.Agent, as: BookingAgent
  alias Exflight.Bookings.Booking

  def create(from_date, to_date, filename \\ "report.csv") do
    [ano, mes, dia] =
      String.split(from_date, "-")
      |>Enum.map(&String.to_integer(&1))
    {:ok, data_ini} = Date.new(ano, mes, dia)

    [ano, mes, dia] =
      String.split(to_date, "-")
      |>Enum.map(&String.to_integer(&1))
    {:ok, data_fim} = Date.new(ano, mes, dia)

    to_report = BookingAgent.list_all()
    |>Map.values()
    |>Enum.filter(&on_date(&1, data_ini, data_fim)) #eh, sei lá podia ser o agent mesmo
    |>Enum.map(&string_booking(&1))

    File.write(filename, to_report)
  end

  defp string_booking(%Booking{id: id, data_completa: data_completa, cidade_destino: destino, cidade_origem: origem}) do
    "#{id},#{origem},#{destino},#{data_completa}\n"
  end

  defp on_date(%Booking{data_completa: data_booking}, data_ini, data_fim) do
    data = NaiveDateTime.to_date(data_booking)
    ini = Date.compare(data, data_ini)
    fim = Date.compare(data, data_fim)
    cond do
     (ini == :gt or ini== :eq) and (fim == :lt or fim == :eq) -> true
     true -> false #hehe
    end
  end
end
