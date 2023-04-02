defmodule FetchTest do
  use ExUnit.Case, async: true

  setup do
    [record_id: create_record["id"]]
  end

  test "get_list/2 works", context do
    {:ok, res} = PocketFlask.get_list("posts")
    assert res.status == 200
  end

  test "get_list!/2 works", context do
    res = PocketFlask.get_list!("posts")
    assert res.status == 200
  end

  test "get_one/3 works", context do
    {:ok, res} = PocketFlask.get_one("posts", context[:record_id])
    assert res.status == 200
  end

  test "get_one!/3 works", context do
    res = PocketFlask.get_one!("posts", context[:record_id])
    assert res.status == 200
    assert res.body["id"] == context[:record_id]
    assert res.body["title"] == "Test Post"
  end

  def create_record do
    res = PocketFlask.create!("posts", %{title: "Test Post"})
    res.body
  end
end
