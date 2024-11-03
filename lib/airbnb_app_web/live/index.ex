defmodule AirbnbAppWeb.PropertyLive.Index do
  use AirbnbAppWeb, :live_view

  alias AirbnbApp.Properties
  alias AirbnbAppWeb.Router.Helpers, as: Routes


  def mount(_params, _session, socket) do
    properties = Properties.search_properties("")
    {:ok, assign(socket, properties: properties)}
  end

  def handle_event("delete_property", %{"id" => id}, socket) do
    case Properties.delete_property(id) do
      {:ok, _property} ->
        properties = Properties.list_properties()
        {:noreply, assign(socket, properties: properties)}
      {:error, _reason} ->
        {:noreply, socket}
    end
  end

  def get_preview_text(property) do
    preview_length = 100
    description = property.description || ""
    preview = String.slice(description, 0, preview_length)
    "#{preview}..."
  end



end
