defmodule HelloK8s.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {HelloK8s.Repo, []},
      {Plug.Cowboy, 
        scheme: :http, 
        plug: HelloK8s.Router, 
        options: [port: 4000],
        num_options:  [num_acceptors: 10]}
    ]

    opts = [strategy: :one_for_one, name: HelloK8s.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
