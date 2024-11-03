defmodule AirbnbApp.Repo.Migrations.CreateBookings do
  use Ecto.Migration

  def change do
    create table(:bookings) do
      add :start_date, :date
      add :end_date, :date
      add :user_id, references(:users, on_delete: :nothing)
      add :property_id, references(:properties, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:bookings, [:user_id])
    create index(:bookings, [:property_id])
  end
end
