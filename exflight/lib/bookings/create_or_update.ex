defmodule Exflight.Bookings.CreateOrUpdate do
  alias Exflight.Bookings.Booking
  alias Exflight.Bookings.Agent, as: BookingAgent
  alias Exflight.Users.Agent, as: UserAgent

  def call(%{ano: ano, dia: dia, mes: mes, cidade_origem: cidade_origem, cidade_destino: cidade_destino, id_usuario: id_usuario }) do
    with {:ok, _} <- UserAgent.get(id_usuario) do #Usuario existe
      Booking.build(ano, mes, dia, cidade_origem, cidade_destino, id_usuario)
      |>handle_save()
    end
  end

  defp handle_save({:ok, %Booking{id: id} = booking}) do
      BookingAgent.save(booking)
      {:ok, id}
    end
    defp handle_save({:error, _} = err), do: err
end
