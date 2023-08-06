defmodule CreateTest do
  alias ExUnit.Test
  use ExUnit.Case, async: true

  test "create/2 works" do
    {:ok, res} = PocketFlask.create("posts", %{title: "Test Post"}, PocketFlask.TestStruct)
    assert res.status == 200
  end

  test "create!/2 works" do
    res = PocketFlask.create!("posts", %{title: "Test Post"}, PocketFlask.TestStruct)
    assert res.status == 200
  end
end
