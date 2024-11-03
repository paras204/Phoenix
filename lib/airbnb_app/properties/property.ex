defmodule AirbnbApp.Properties.Property do
  use Ecto.Schema
  import Ecto.Changeset

  schema "properties" do
    field :name, :string
    field :description, :string
    field :location, :string
    field :price, :decimal
    field :image_url, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(property, attrs) do
    property
  |> cast(attrs, [:name, :location, :description, :price , :image_url])
    |> validate_required([:name, :location, :description, :price ])
  end
end
