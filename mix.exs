defmodule Stack.Mixfile do
  use Mix.Project

  def project do
    [app: :stack,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps()]
  end

  # Configuration for the OTP application
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger],
    mod: {Stack, []}]
  end

  def deps do
    []
  end
end
