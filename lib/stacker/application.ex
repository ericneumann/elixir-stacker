defmodule Stacker.Application do

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Stacker.Server, ["frank", "bob", "mary", "ed"]}
    ]

    opts = [strategy: :one_for_one, name: Sequence.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
