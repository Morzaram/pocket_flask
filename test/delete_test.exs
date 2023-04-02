defmodule DeleteTest do
  use ExUnit.Case, async: true

  setup do
    [record_id: create_record["id"]]
  end

  test "delete/2 works", context do
    {:ok, res} = PocketFlask.delete("posts", context[:record_id]) |> dbg
    assert res.status == 204
    assert res.body == ""
  end

  test "delete!/2 works", context do
    res = PocketFlask.delete!("posts", context[:record_id]) |> dbg
    assert res.status == 204
    assert res.body == ""
  end

  def create_record do
    res = PocketFlask.create!("posts", %{title: "Test Post"})
    res.body
  end
end
