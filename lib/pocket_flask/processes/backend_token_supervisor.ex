defmodule PocketFlask.Processes.BackendTokenSupervisor do
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, nil, name: :backend_token_supervisor)
  end

  def init(_elements) do
    children = [
      PocketFlask.Processes.BackendTokenServer
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
