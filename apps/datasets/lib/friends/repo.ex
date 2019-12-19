defmodule Friends.Repo do
  use Ecto.Repo,
    otp_app: :datasets,
    adapter: Ecto.Adapters.Postgres
end
