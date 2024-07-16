defmodule Vms.VolunteersTest do
  use Vms.DataCase

  alias Vms.Volunteers

  describe "volunteers" do
    alias Vms.Volunteers.Volunteer

    import Vms.VolunteersFixtures

    @invalid_attrs %{name: nil, surname: nil, email: nil, st0: nil, st1: nil, sun0: nil, sun1: nil}

    test "list_volunteers/0 returns all volunteers" do
      volunteer = volunteer_fixture()
      assert Volunteers.list_volunteers() == [volunteer]
    end

    test "get_volunteer!/1 returns the volunteer with given id" do
      volunteer = volunteer_fixture()
      assert Volunteers.get_volunteer!(volunteer.id) == volunteer
    end

    test "create_volunteer/1 with valid data creates a volunteer" do
      valid_attrs = %{name: "some name", surname: "some surname", email: "some email", st0: true, st1: true, sun0: true, sun1: true}

      assert {:ok, %Volunteer{} = volunteer} = Volunteers.create_volunteer(valid_attrs)
      assert volunteer.name == "some name"
      assert volunteer.surname == "some surname"
      assert volunteer.email == "some email"
      assert volunteer.st0 == true
      assert volunteer.st1 == true
      assert volunteer.sun0 == true
      assert volunteer.sun1 == true
    end

    test "create_volunteer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Volunteers.create_volunteer(@invalid_attrs)
    end

    test "update_volunteer/2 with valid data updates the volunteer" do
      volunteer = volunteer_fixture()
      update_attrs = %{name: "some updated name", surname: "some updated surname", email: "some updated email", st0: false, st1: false, sun0: false, sun1: false}

      assert {:ok, %Volunteer{} = volunteer} = Volunteers.update_volunteer(volunteer, update_attrs)
      assert volunteer.name == "some updated name"
      assert volunteer.surname == "some updated surname"
      assert volunteer.email == "some updated email"
      assert volunteer.st0 == false
      assert volunteer.st1 == false
      assert volunteer.sun0 == false
      assert volunteer.sun1 == false
    end

    test "update_volunteer/2 with invalid data returns error changeset" do
      volunteer = volunteer_fixture()
      assert {:error, %Ecto.Changeset{}} = Volunteers.update_volunteer(volunteer, @invalid_attrs)
      assert volunteer == Volunteers.get_volunteer!(volunteer.id)
    end

    test "delete_volunteer/1 deletes the volunteer" do
      volunteer = volunteer_fixture()
      assert {:ok, %Volunteer{}} = Volunteers.delete_volunteer(volunteer)
      assert_raise Ecto.NoResultsError, fn -> Volunteers.get_volunteer!(volunteer.id) end
    end

    test "change_volunteer/1 returns a volunteer changeset" do
      volunteer = volunteer_fixture()
      assert %Ecto.Changeset{} = Volunteers.change_volunteer(volunteer)
    end
  end
end
