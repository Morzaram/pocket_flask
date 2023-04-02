defmodule UpdateTest do
  use ExUnit.Case, async: true

  setup do
    [record_id: create_record()["id"]]
  end

  test "update/3 works", context do
    {:ok, res} = PocketFlask.update("posts", context[:record_id], %{title: "Test Post 1"})
    assert res.status == 200
    assert res.body["title"] == "Test Post 1"
  end

  test "update!/3 works", context do
    res = PocketFlask.update!("posts", context[:record_id], %{title: "Test Post 2"})
    assert res.status == 200
    assert res.body["title"] == "Test Post 2"
  end

  def create_record do
    res = PocketFlask.create!("posts", %{title: "Test Post"})
    res.body
  end
end
