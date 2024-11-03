defmodule AirbnbAppWeb.AboutLive do
  use AirbnbAppWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @spec render(any()) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <div class="about-page">
      <h1>About Us</h1>
      <p>Welcome to AirbnbApp! We are dedicated to providing the best travel experiences.</p>
      <p>Our mission is to connect people with unique accommodations around the world.</p>
    </div>
    """
  end
end
