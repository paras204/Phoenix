defmodule AirbnbApp.Bookings.Booking do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bookings" do
    field :start_date, :date
    field :end_date, :date
    field :user_id, :id
    field :property_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(booking, attrs) do
    booking
    |> cast(attrs, [:start_date, :end_date , :property_id , :user_id])
    |> validate_required([:start_date, :end_date  , :property_id])
  end
end
