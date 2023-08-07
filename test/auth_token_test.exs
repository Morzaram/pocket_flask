defmodule AuthTokenTest do
  use ExUnit.Case

  test "refresh_token/2 refreshes the token" do
    {:ok, pid} = PocketFlask.AuthToken.start_link()
    token = :sys.get_state(pid)
    assert !is_nil(token)

    PocketFlask.AuthToken.refresh_token(pid) |> dbg
    token = :sys.get_state(pid)
    assert !is_nil(token)
    # assert_receive {:noreply, new_token} =
    #                  PocketFlask.AuthToken.refresh_token(pid, "default_token")

    # assert new_token != "default_token"
  end

  # Ensure that it will recover from errors
  # Ensure that it starts on start up
end
