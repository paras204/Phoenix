defmodule AirbnbApp.Repo do
  use Ecto.Repo,
    otp_app: :airbnb_app,
    adapter: Ecto.Adapters.Postgres
end
