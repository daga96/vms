defmodule Vms.Repo do
  use Ecto.Repo,
    otp_app: :vms,
    adapter: Ecto.Adapters.SQLite3
end
