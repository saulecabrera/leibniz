defmodule Leibniz.MixProject do
  use Mix.Project

  @desc "Math expression parser and evaluator"

  def project do
    [
      app: :leibniz,
      version: "1.0.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: @desc,
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package() do
    [
      name: "leibniz",
      maintainers: ["Saúl Cabrera"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/saulecabrera/leibniz"}
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.16", only: :dev, runtime: false}
    ]
  end
end
