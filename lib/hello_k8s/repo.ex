defmodule HelloK8s.Repo do
  use Ecto.Repo,
    otp_app: :hello_k8s,
    adapter: Ecto.Adapters.Postgres
end
