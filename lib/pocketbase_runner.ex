defmodule PocketBaseRunner do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    # Start PocketBase as an external program in the background
    cmd = "./pocketbase serve"
    port = Port.open({:spawn, cmd}, [:binary, :exit_status])

    # Monitor the port
    Process.monitor(port)

    # Store the port in the state
    {:ok, %{port: port}}
  end

  def terminate(_, state) do
    # Close the port (kill the external process) when terminating the GenServer
    Port.close(state.port)
    :ok
  end

  def handle_info({:DOWN, _ref, :port, _object, _reason}, state) do
    # Handle the exit of the external process
    IO.puts("PocketBase exited.")
    {:stop, :normal, state}
  end
end
