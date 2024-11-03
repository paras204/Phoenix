defmodule AirbnbApp.Repo.Migrations.CreateProperties do
  use Ecto.Migration

  def change do
    create table(:properties) do
      add :name, :string
      add :location, :string
      add :description, :text
      add :price, :decimal
      add :created_at, :utc_datetime
      timestamps(type: :utc_datetime)
    end
  
  end
end
