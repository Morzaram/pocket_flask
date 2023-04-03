defmodule PocketBaseRunner do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    # Start PocketBase as an external program in the background
    System.cmd("sh", ["-c", "kill $(lsof -t -i:8090)"])

    cmd = "./pocketbase serve"
    port = Port.open({:spawn, cmd}, [:binary, :exit_status]) |> dbg

    # Monitor the port
    Process.monitor(self())

    # Store the port in the state
    {:ok, %{port: port}}
  end

  def terminate(_, state) do
    # Close the port (kill the external process) when terminating the GenServer
    IO.puts("PocketBaseRunner.terminate")
    System.cmd("sh", ["-c", "kill $(lsof -t -i:8090)"])
    Port.close(state.port)
    :ok
  end

  def handle_cast(:stop, state) do
    # Handle the exit of the external process
    Port.close(state.port)
    IO.puts("PocketBase exited.")
    {:stop, :normal, state}
  end

  def handle_info({port, {:data, data}}, state) do
    IO.puts("PocketBase: #{data}")
    {:noreply, state}
  end

  # PocketBaseRunner.handle_info({#Port<0.4>, {:exit_status, 1}}, %{port: #Port<0.4>})
  def handle_info({port, {:exit_status, status}}, state) do
    IO.puts("PocketBase exited with status #{status}")
    {:stop, :normal, state}
  end
end

defmodule PocketBaseMain do
  # Define a function to start a supervisor and the worker as its child
  def start_supervised_worker do
    # Define the child specification
    child_spec = %{
      id: PocketBaseRunner,
      start: {PocketBaseRunner, :start_link, []},
      restart: :temporary,
      type: :worker
    }

    # Start the supervisor with the child specification
    {:ok, sup} = Supervisor.start_link([child_spec], strategy: :one_for_one)

    # Simulate stopping the worker after some time
    # Process.send_after(self(), :stop_worker, 3_000)

    # Wait for messages to stop the worker
    receive do
      :stop_worker ->
        GenServer.cast(PocketBaseRunner, :stop)
    end

    # Stop the supervisor after some time
    # Process.send_after(self(), :stop_supervisor, 5_000)

    # Wait for messages to stop the supervisor
    receive do
      :stop_supervisor ->
        Supervisor.stop(sup)
    end
  end
end

# Run the function to start the supervisor and worker
PocketBaseMain.start_supervised_worker()
