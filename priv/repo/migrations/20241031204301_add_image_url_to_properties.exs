defmodule AirbnbApp.Repo.Migrations.AddImageUrlToProperties do
  use Ecto.Migration

  def change do
    alter table(:properties) do
      # Add your new column here
      add :image_url, :string
    end
  end
end
