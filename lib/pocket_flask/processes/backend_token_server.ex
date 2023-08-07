defmodule PocketFlask.Processes.BackendTokenServer do
  use GenServer

  import Logger

  @name :backend_token
  @milliseconds_before_token_refresh 60 * 1000

  # Client

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: @name)
  end

  def refresh_token(pid) do
    GenServer.cast(pid, :refresh_token)
  end

  def token(pid) do
    :sys.get_state(pid)
  end

  # Server (callbacks)

  @impl true
  def init(elements) do
    Logger.info("Starting BackendTokenServer")
    run_checks()
    token = authenticate() |> PocketFlask.Authenticate.get_token()
    enqueue_token_refresh()
    Logger.info("Token retrieved, looking good")

    {:ok, token}
  end

  def handle_info(:refresh_token, _state) do
    Logger.info("Refreshing token")
    token = authenticate() |> PocketFlask.Authenticate.get_token()
    enqueue_token_refresh()
    Logger.info("Token retrieved, looking good")
    {:noreply, token}
  end

  defp enqueue_token_refresh() do
    safe_time = Constants.token_refresh_in_milliseconds() - @milliseconds_before_token_refresh
    time = if safe_time < 0, do: Constants.token_refresh_in_milliseconds(), else: safe_time
    Logger.info("Enqueuing token refresh in #{time / 1000} seconds")
    Process.send_after(self(), :refresh_token, time)
  end

  # Private requests

  defp authenticate() do
    PocketFlask.Authenticate.auth_with_password("admins", Constants.email(), Constants.password())
  end

  defp run_checks() do
    Logger.info("Running checks")
    Constants.check_env()
    Logger.info("Checks passed")
  end
end
