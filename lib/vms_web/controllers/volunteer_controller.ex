defmodule VmsWeb.VolunteerController do
  use VmsWeb, :controller

  alias Vms.Volunteers
  alias Vms.Volunteers.Volunteer


  def index(conn, _params) do
    volunteers = Volunteers.list_volunteers()
    render(conn, :index, volunteers: volunteers)
  end

  def create(conn, %{"volunteer" => volunteer_params}) do
    case Volunteers.create_volunteer(volunteer_params) do
      {:ok, %Volunteer{} = volunteer} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", ~p"/api/volunteers/#{volunteer}")
        |> render(:show, volunteer: volunteer)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(VmsWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    volunteer = Volunteers.get_volunteer!(id)
    render(conn, :show, volunteer: volunteer)
  end

  def update(conn, %{"id" => id, "volunteer" => volunteer_params}) do
    volunteer = Volunteers.get_volunteer!(id)

    case Volunteers.update_volunteer(volunteer, volunteer_params) do
      {:ok, %Volunteer{} = volunteer} ->
        render(conn, :show, volunteer: volunteer)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(VmsWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    volunteer = Volunteers.get_volunteer!(id)

    case Volunteers.delete_volunteer(volunteer) do
      {:ok, %Volunteer{}} ->
        send_resp(conn, :no_content, "")

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(VmsWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
