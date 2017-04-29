defmodule GetFunctionalSupervision.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(GetFunctionalSupervision.Account, []),
    ]

    opts = [strategy: :one_for_one, name: GetFunctionalSupervision.Supervisor]
    Supervisor.start_link(children, opts)
  end
end