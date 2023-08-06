ExUnit.start()

defmodule PocketFlask.TestHelper do
  def create_record do
    res = PocketFlask.create!("posts", %{title: "Test Post"}, PocketFlask.TestStruct)
    res.body
  end
end
