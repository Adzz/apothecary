defmodule Apothecary.Mixfile do
  use Mix.Project

  def project do
    [
      app: :maybex,
      version: "0.0.1-dev",
      elixir: "~> 1.5",
      # Docs
      name: "Apothecary",
      source_url: "https://github.com/Adzz/apothecary",
      docs: [
        main: "Apothhecary",
        extras: ["README.md"]
        ],
      start_permanent: Mix.env == :prod,
      deps: deps(),
      description: description(),
      package: package(),
    ]
  end

  def deps() do
    [
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
      {:stream_data, "~> 0.1"},
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description do
    "An apothecary of StreamData generators. These are helpful for property based testing"
  end

  defp package do
    [
      licenses: ["Apache 2.0"],
      maintainers: ["Adam Lancaster"],
      links: %{"Github" => "https://github.com/adzz/apothecary"}
    ]
  end
end

