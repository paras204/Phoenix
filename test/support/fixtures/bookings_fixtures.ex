defmodule AirbnbApp.BookingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AirbnbApp.Bookings` context.
  """

  @doc """
  Generate a booking.
  """
  def booking_fixture(attrs \\ %{}) do
    {:ok, booking} =
      attrs
      |> Enum.into(%{
        end_date: ~D[2024-11-01],
        start_date: ~D[2024-11-01]
      })
      |> AirbnbApp.Bookings.create_booking()

    booking
  end
end
