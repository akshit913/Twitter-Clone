defmodule TwitterClone.Repo do
  use Ecto.Repo,
    otp_app: :twitterClone,
    adapter: Ecto.Adapters.Postgres
end
