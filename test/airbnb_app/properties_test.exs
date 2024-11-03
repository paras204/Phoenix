defmodule AirbnbApp.PropertiesTest do
  use AirbnbApp.DataCase

  alias AirbnbApp.Properties

  describe "properties" do
    alias AirbnbApp.Properties.Property

    import AirbnbApp.PropertiesFixtures

    @invalid_attrs %{name: nil, description: nil, location: nil, price: nil}

    test "list_properties/0 returns all properties" do
      property = property_fixture()
      assert Properties.list_properties() == [property]
    end

    test "get_property!/1 returns the property with given id" do
      property = property_fixture()
      assert Properties.get_property!(property.id) == property
    end

    test "create_property/1 with valid data creates a property" do
      valid_attrs = %{name: "some name", description: "some description", location: "some location", price: "120.5"}

      assert {:ok, %Property{} = property} = Properties.create_property(valid_attrs)
      assert property.name == "some name"
      assert property.description == "some description"
      assert property.location == "some location"
      assert property.price == Decimal.new("120.5")
    end

    test "create_property/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Properties.create_property(@invalid_attrs)
    end

    test "update_property/2 with valid data updates the property" do
      property = property_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description", location: "some updated location", price: "456.7"}

      assert {:ok, %Property{} = property} = Properties.update_property(property, update_attrs)
      assert property.name == "some updated name"
      assert property.description == "some updated description"
      assert property.location == "some updated location"
      assert property.price == Decimal.new("456.7")
    end

    test "update_property/2 with invalid data returns error changeset" do
      property = property_fixture()
      assert {:error, %Ecto.Changeset{}} = Properties.update_property(property, @invalid_attrs)
      assert property == Properties.get_property!(property.id)
    end

    test "delete_property/1 deletes the property" do
      property = property_fixture()
      assert {:ok, %Property{}} = Properties.delete_property(property)
      assert_raise Ecto.NoResultsError, fn -> Properties.get_property!(property.id) end
    end

    test "change_property/1 returns a property changeset" do
      property = property_fixture()
      assert %Ecto.Changeset{} = Properties.change_property(property)
    end
  end
end
