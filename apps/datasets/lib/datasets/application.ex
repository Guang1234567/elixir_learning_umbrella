defmodule Datasets.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Datasets.Worker.start_link(arg)
      # {Datasets.Worker, arg}
      {Friends.Repo, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Datasets.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
