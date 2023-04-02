defmodule PocketFlask.MixProject do
  use Mix.Project

  def project do
    [
      app: :pocket_flask,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:req, "~> 0.3"},
      {:nestru, "~> 0.3.2"},
      {:key_convert, "~> 0.5.0"}
    ]
  end
end
