defmodule Vms.Volunteers.Volunteer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "volunteers" do
    field :name, :string
    field :surname, :string
    field :email, :string
    field :st0, :boolean, default: false
    field :st1, :boolean, default: false
    field :sun0, :boolean, default: false
    field :sun1, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(volunteer, attrs) do
    volunteer
    |> cast(attrs, [:name, :surname, :email, :st0, :st1, :sun0, :sun1])
    |> validate_required([:name, :surname, :email, :st0, :st1, :sun0, :sun1])
  end
end
