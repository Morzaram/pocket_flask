defmodule FetchTest do
  use ExUnit.Case, async: true

  setup do
    [record_id: create_record()["id"]]
  end

  test "get_list/2 works" do
    {:ok, res} = PocketFlask.get_list("posts")
    assert res.status == 200
  end

  test "get_list!/2 works" do
    res = PocketFlask.get_list!("posts")
    assert res.status == 200
  end

  def create_record do
    res = PocketFlask.create!("posts", %{title: "Test Post"})
    res.body
  end
end
