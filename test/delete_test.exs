defmodule DeleteTest do
  use ExUnit.Case, async: true
  import PocketFlask.TestHelper

  setup do
    [record_id: create_record().id]
  end

  test "delete/2 works", context do
    {:ok, res} = PocketFlask.delete("posts", context[:record_id])
    assert res.status == 204
    assert res.body == ""
  end

  test "delete!/2 works", context do
    res = PocketFlask.delete!("posts", context[:record_id])
    assert res.status == 204
    assert res.body == ""
  end
end
