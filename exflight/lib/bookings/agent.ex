defmodule Exflight.Bookings.Agent do
  alias Exflight.Bookings.Booking
  use Agent

  def start_link(%{}), do: Agent.start_link(fn -> %{} end, name: __MODULE__)

  def save(%Booking{} = booking), do: Agent.update(__MODULE__, &update_state(&1, booking))
  defp update_state(state, %Booking{id: id} = booking), do: Map.put(state, id, booking)

  def get(id), do: Agent.get(__MODULE__, &get_booking(&1, id))
  defp get_booking(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "Booking not found"}
      booking -> {:ok, booking}
    end
  end

  def list_all(), do: Agent.get(__MODULE__, & &1)
end
