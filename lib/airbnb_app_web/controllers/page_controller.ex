defmodule AirbnbAppWeb.PageController do
  use AirbnbAppWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end
  def redirect_to_properties(conn, _params) do
    redirect(conn, to: "/properties")
  end

end
