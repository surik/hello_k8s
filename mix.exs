defmodule HelloK8s.MixProject do
  use Mix.Project

  def project do
    [
      app: :hello_k8s,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {HelloK8s.Application, []}
    ]
  end

  defp deps do
    [
      {:ecto_sql,     "~> 3.0"},
      {:postgrex,     "~> 0.14.0"},
      {:plug_cowboy,  "~> 2.0"},
      {:jason,        "~> 1.1"},
      {:distillery, "~> 2.0", runtime: false},
    ]
  end
end
