defmodule Ash.MixProject do
  use Mix.Project

  def project do
    [
      app: :ash,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Ash.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support", "test/factories"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # HTTP Server
      {:corsica, "~> 1.1.2"},
      {:plug_cowboy, "~> 2.1.0"},
      {:poison, "~> 4.0.1"},
      {:httpoison, "~> 1.6"},

      # Phoenix
      {:jason, "~> 1.1"},
      {:phoenix, "~> 1.4.11"},
      {:phoenix_ecto, "~> 4.1"},
      {:phoenix_html, "~> 2.13.3"},
      {:phoenix_pubsub, "~> 1.1.2"},

      # Database
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},

      # GraphQL
      {:absinthe, "~> 1.4.16"},
      {:absinthe_plug, "~> 1.4.7"},
      {:absinthe_ecto, "~> 0.1.3"},
      {:absinthe_phoenix, "~> 1.4.4"},
      {:dataloader, "~> 1.0.6"},

      # Authentication
      {:argon2_elixir, "~> 2.1.2"},
      {:comeonin, "~> 5.1.3"},
      {:guardian, "~> 2.0.0"},

      # Misc
      {:gettext, "~> 0.11"},  # Translations
      {:bamboo, "~> 1.1"},    # Email

      # Test Utils
      {:ex_machina, "~> 2.3", only: :test},
      {:faker, "~> 0.11", only: :test},
      {:excoveralls, "~> 0.10", only: :test},
      {:mix_test_watch, "~> 1.0", only: :dev, runtime: false}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "ecto.seed": ["run priv/repo/seeds.exs"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
