defmodule AirbnbAppWeb.BookingLive.New do
  use AirbnbAppWeb, :live_view
  alias AirbnbApp.Bookings
  alias AirbnbApp.Properties
  alias AirbnbApp.Bookings
  alias AirbnbApp.Bookings.Booking
  alias AirbnbAppWeb.Router.Helpers, as: Routes


  def mount(%{"id" => listing_id}, _session, socket) do
    listing = Properties.get_property!(listing_id)
    changeset = Bookings.change_booking(%Booking{})

    socket =
      assign(socket,
        listing: listing,
        changeset: changeset,
        current_user: nil
      )

    {:ok, socket}
  end



  def handle_event("save", %{"booking" => booking_params}, socket) do
    start_date = Date.from_iso8601!(booking_params["start_date"])
    end_date = Date.from_iso8601!(booking_params["end_date"])
    property_id = booking_params["property_id"]

    if Bookings.date_clash(start_date, end_date, property_id) do
      {:noreply, socket |> put_flash(:error, "The selected dates are not available.")}
    else
    case Bookings.create_booking(booking_params) do
      {:ok, _booking} ->
        {:noreply, socket |> put_flash(:info, "Booking successful!") |> redirect(to: "/")}
        {:error, _reason} ->
          {:noreply, socket |> put_flash(:error, "Booking failed. Please try again.")}
        {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
      end
    end
  end

  def handle_event("validate", %{"booking" => booking_params}, socket) do
    changeset = Bookings.change_booking(%Booking{}, booking_params)
   {:noreply, assign(socket, :form, to_form(changeset))}
  end
  def render(assigns) do
    ~H"""
     <style>
        .navbar {
            width: 100%;
            background-color: #333;
            color: #fff;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .navbar a {
            color: #fff;
            text-decoration: none;
            margin: 0 10px;
            transition: color 0.3s;
        }

        .navbar a:hover {
            color: #ff5a5f;
        }

        .property {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 16px;
            margin-bottom: 16px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .property:hover {
            transform: scale(1.02);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .property h3 {
            margin-top: 0;
            color: #333;
        }

        .property p {
            color: #666;
        }

        .property img {
            max-width: 100%;
            border-radius: 8px;
            margin-bottom: 16px;
        }

        .property button {
            background-color: #ff5a5f;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
        }

        .property button:hover {
            background-color: #e04e4e;
            transform: scale(1.05);
        }

        form {
            display: flex;
            flex-direction: column;
        }

        form label {
            margin-top: 10px;
            margin-bottom: 5px;
            color: #333;
        }

        form input[type="date"] {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-bottom: 10px;
        }

        form button {
            align-self: flex-start;
        }
    </style>
    <div class="navbar">
        <div class="navbar-brand">Airbnb</div>
        <div class="navbar-links">
            <a href="/">Home</a>
            <a href="/properties">Properties</a>
            <a href="/contact">Contact</a>
        </div>
    </div>
    <div class="property">
      <h3><%= @listing.name %></h3>
      <p><%= @listing.description %></p>
      <img src={@listing.image_url} alt={@listing.name}>
      <p>Price: $<%= @listing.price %></p>
      <p>Location: <%= @listing.location %></p>
    </div>
    <form phx-submit="save" phx-change="validate">
      <input type="hidden" name="booking[property_id]" value={@listing.id}>

      <label for="booking_start_date">Start Date</label>
      <input type="date" name="booking[start_date]" id="booking_start_date" phx-debounce="500" value={@changeset.data.start_date || ""}>
      <label for="booking_end_date">End Date</label>
      <input type="date" name="booking[end_date]" id="booking_end_date" phx-debounce="500" value={@changeset.data.end_date || ""}>
      <button type="submit">Book</button>
    </form>
    """
  end
  end
