defmodule UpdateTest do
  use ExUnit.Case, async: true
  import PocketFlask.TestHelper

  setup do
    [record_id: create_record().id]
  end

  test "update/3 works", context do
    {:ok, res} =
      PocketFlask.update(
        "posts",
        context[:record_id],
        %{title: "Test Post 1"},
        PocketFlask.TestStruct
      )

    assert res.body.title == "Test Post 1"
  end

  test "update!/3 works", context do
    res =
      PocketFlask.update!(
        "posts",
        context[:record_id],
        %{title: "Test Post 2"},
        PocketFlask.TestStruct
      )

    assert res.body.title == "Test Post 2"
  end
end
