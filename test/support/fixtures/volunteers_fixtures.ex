defmodule Vms.VolunteersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Vms.Volunteers` context.
  """

  @doc """
  Generate a volunteer.
  """
  def volunteer_fixture(attrs \\ %{}) do
    {:ok, volunteer} =
      attrs
      |> Enum.into(%{
        email: "some email",
        name: "some name",
        st0: true,
        st1: true,
        sun0: true,
        sun1: true,
        surname: "some surname"
      })
      |> Vms.Volunteers.create_volunteer()

    volunteer
  end
end
