defmodule AirbnbAppWeb.YourPropertiesLive do
  use AirbnbAppWeb, :live_view
  alias AirbnbApp.Bookings
  alias AirbnbApp.Properties

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :bookings, Bookings.list_bookings())}
  end

  def handle_event("delete_booking", %{"id" => id}, socket) do
    case Bookings.delete_booking(id) do
      {:ok, _property} ->
        bookings = Bookings.list_bookings()
        {:noreply, assign(socket, bookings: bookings)}
      {:error, _reason} ->
        {:noreply, socket}
    end
  end

  def render(assigns) do
    ~H"""
    <style>
      .booking-list {
        list-style-type: none;
        padding: 0;
      }
      .booking-item {
        margin-bottom: 20px;
      }
      .booking-item img {
        max-width: 100px;
        height: auto;
      }
      .booking-item button {
        background-color: #ff5a5f;
        color: white;
        border: none;
        padding: 10px;
        cursor: pointer;
      }
      .booking-item button:hover {
        background-color: #e04848;
      }
    </style>

    <h1>Your Bookings</h1>
    <ul class="booking-list">
      <%= for booking <- @bookings do %>
        <li class="booking-item">
          <div>
            <% property = Properties.get_property!(booking.property_id) %>
            <img src={property.image_url} alt={property.name} />
          </div>
          <div>
            <%= booking.start_date %> - <%= booking.end_date %>
            <button phx-click="delete_booking" phx-value-id={booking.id}>Delete </button>
          </div>
        </li>
      <% end %>
    </ul>
    """
  end
end
