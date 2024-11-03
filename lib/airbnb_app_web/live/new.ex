defmodule AirbnbAppWeb.PropertyLive.New do
  use AirbnbAppWeb, :live_view
  alias AirbnbApp.Properties
  alias AirbnbApp.Properties.Property

  def mount(_params, _session, socket) do
    socket =
      assign(
        socket,
        form: to_form(Properties.change_property(%Property{}))
      )

    {:ok, socket}
  end

  def handle_event("save", %{"property" => property_params}, socket) do
    case Properties.create_property(property_params) do
      {:ok, _property} ->
        {:noreply, redirect(socket, to: "/properties")}
      {:error, %Ecto.Changeset{} = changeset} ->
       {:noreply, assign(socket, :form, to_form(changeset))}
    end
  end
  def handle_event("validate", %{"property" => property_params}, socket) do
    changeset = Properties.change_property(%Property{}, property_params)
   {:noreply, assign(socket, :form, to_form(changeset))}
  end
end
