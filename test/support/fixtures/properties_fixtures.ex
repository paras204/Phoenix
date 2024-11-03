defmodule AirbnbApp.PropertiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AirbnbApp.Properties` context.
  """

  @doc """
  Generate a property.
  """
  def property_fixture(attrs \\ %{}) do
    {:ok, property} =
      attrs
      |> Enum.into(%{
        description: "some description",
        location: "some location",
        name: "some name",
        price: "120.5"
      })
      |> AirbnbApp.Properties.create_property()

    property
  end
end
