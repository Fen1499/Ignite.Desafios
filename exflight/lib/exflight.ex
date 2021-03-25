defmodule Exflight do
  alias Exflight.Users.CreateOrUpdate, as: CreateOrUpdateUsers
  alias Exflight.Users.Agent, as: UserAgent
  alias Exflight.Bookings.CreateOrUpdate, as: CreateOrUpdateBookings
  alias Exflight.Bookings.Agent, as: BookingAgent

  def start_agents do
    UserAgent.start_link(%{})
    BookingAgent.start_link(%{})
  end

  defdelegate create_or_update_user(params), to: CreateOrUpdateUsers, as: :call
  defdelegate create_or_update_booking(params), to: CreateOrUpdateBookings, as: :call
end
