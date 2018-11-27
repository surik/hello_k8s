use Mix.Config

config :hello_k8s, HelloK8s.Repo,
  database: "hello_k8s_repo",
  username: "postgres",
  password: "pass",
  port: 5432,
  hostname: "localhost"

config :hello_k8s, ecto_repos: [HelloK8s.Repo]

import_config "#{Mix.env}.exs"
