defmodule VmsWeb.VolunteerJSON do
  alias Vms.Volunteers.Volunteer

  @doc """
  Renders a list of volunteers.
  """
  def index(%{volunteers: volunteers}) do
    %{data: for(volunteer <- volunteers, do: data(volunteer))}
  end

  @doc """
  Renders a single volunteer.
  """
  def show(%{volunteer: volunteer}) do
    %{data: data(volunteer)}
  end

  defp data(%Volunteer{} = volunteer) do
    %{
      id: volunteer.id,
      name: volunteer.name,
      surname: volunteer.surname,
      email: volunteer.email,
      st0: volunteer.st0,
      st1: volunteer.st1,
      sun0: volunteer.sun0,
      sun1: volunteer.sun1,
      timestamp: NaiveDateTime.utc_now()
    }
  end
end
