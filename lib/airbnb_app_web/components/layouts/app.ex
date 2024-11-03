defmodule AirbnbAppWeb.Layouts.App do
  alias Phoenix.LiveView.JS
  

  def toggle_dropdown_menu do
    JS.toggle(
      to: "#dropdown_menu",
      in: {"ease-out duration-300", "opacity-0", "opacity-100"},
      out: {"ease-in duration-300", "opacity-100", "opacity-0"}
    )
  end
end
