defmodule Vms.Repo.Migrations.CreateVolunteers do
  use Ecto.Migration

  def change do
    create table(:volunteers) do
      add :name, :string
      add :surname, :string
      add :email, :string
      add :st0, :boolean, default: false, null: false
      add :st1, :boolean, default: false, null: false
      add :sun0, :boolean, default: false, null: false
      add :sun1, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
