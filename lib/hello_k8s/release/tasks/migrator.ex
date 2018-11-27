defmodule HelloK8s.Release.Tasks.Migrator do
  @moduledoc """
  Migration tasks.
  """


  @start_apps [:postgrex, :ecto_sql]

  @app :hello_k8s

  #######
  # API #
  #######
  def repos, do: Application.get_env(@app, :ecto_repos, [])

  @doc "Run migrations"
  def migrate do
    start_services()

    Enum.each(repos(), &run_migrations_for/1)
    IO.puts("Migrations successful!")

    stop_services()
  end

  @doc """
  Rollback migrations.
  """
  def rollback(steps \\ 1) do
    start_services()

    Enum.each(repos(), fn repo -> run_rollbacks_for(repo, steps) end)
    IO.puts("Rollback successful!")

    stop_services()
  end

  ###########
  # Private #
  ###########
  defp start_services do
    IO.puts("Loading #{@app}..")
    # Load the code for the application, but don't start it
    :ok = Application.load(@app)

    IO.puts("Starting dependencies..")
    # Start apps necessary for executing migrations
    Enum.each(@start_apps, &Application.ensure_all_started/1)

    # Start the Repo(s) for the application
    IO.puts("Starting repos..")
    Enum.each(repos(), & &1.start_link(pool_size: 2))
  end

  defp stop_services do
    :init.stop()
  end

  defp run_migrations_for(repo) do
    app = Keyword.get(repo.config, :otp_app)
    IO.puts("Running migrations for #{app}")
    Ecto.Migrator.run(repo, migrations_path(repo), :up, all: true)
  end

  defp run_rollbacks_for(repo, step) do
    app = Keyword.get(repo.config, :otp_app)
    IO.puts("Running rollbacks for #{app} (STEP=#{step})")
    Ecto.Migrator.run(repo, migrations_path(repo), :down, all: false, step: step)
  end

  defp migrations_path(repo), do: priv_path_for(repo, "migrations")

  defp priv_path_for(repo, filename) do
    app = Keyword.get(repo.config, :otp_app)
    IO.puts("App: #{app}")

    repo_underscore =
      repo
      |> Module.split()
      |> List.last()
      |> Macro.underscore()

    Path.join([priv_dir(app), repo_underscore, filename])
  end

  defp priv_dir(app), do: "#{:code.priv_dir(app)}"
end
