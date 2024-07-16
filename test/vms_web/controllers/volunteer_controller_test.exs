defmodule VmsWeb.VolunteerControllerTest do
  use VmsWeb.ConnCase

  import Vms.VolunteersFixtures

  alias Vms.Volunteers.Volunteer

  @create_attrs %{
    name: "some name",
    surname: "some surname",
    email: "some email",
    st0: true,
    st1: true,
    sun0: true,
    sun1: true
  }
  @update_attrs %{
    name: "some updated name",
    surname: "some updated surname",
    email: "some updated email",
    st0: false,
    st1: false,
    sun0: false,
    sun1: false
  }
  @invalid_attrs %{name: nil, surname: nil, email: nil, st0: nil, st1: nil, sun0: nil, sun1: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all volunteers", %{conn: conn} do
      conn = get(conn, ~p"/api/volunteers")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create volunteer" do
    test "renders volunteer when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/volunteers", volunteer: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/volunteers/#{id}")

      assert %{
               "id" => ^id,
               "email" => "some email",
               "name" => "some name",
               "st0" => true,
               "st1" => true,
               "sun0" => true,
               "sun1" => true,
               "surname" => "some surname"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/volunteers", volunteer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update volunteer" do
    setup [:create_volunteer]

    test "renders volunteer when data is valid", %{conn: conn, volunteer: %Volunteer{id: id} = volunteer} do
      conn = put(conn, ~p"/api/volunteers/#{volunteer}", volunteer: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/volunteers/#{id}")

      assert %{
               "id" => ^id,
               "email" => "some updated email",
               "name" => "some updated name",
               "st0" => false,
               "st1" => false,
               "sun0" => false,
               "sun1" => false,
               "surname" => "some updated surname"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, volunteer: volunteer} do
      conn = put(conn, ~p"/api/volunteers/#{volunteer}", volunteer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete volunteer" do
    setup [:create_volunteer]

    test "deletes chosen volunteer", %{conn: conn, volunteer: volunteer} do
      conn = delete(conn, ~p"/api/volunteers/#{volunteer}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/volunteers/#{volunteer}")
      end
    end
  end

  defp create_volunteer(_) do
    volunteer = volunteer_fixture()
    %{volunteer: volunteer}
  end
end
