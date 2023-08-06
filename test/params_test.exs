defmodule ParamsTest do
  use ExUnit.Case, async: true
  import PocketFlask.TestHelper

  # setup do
  #   # [record_id: create_record().id]
  # end

  test "get_list/2 works with params" do
    {:ok, res} =
      PocketFlask.get_list("posts", PocketFlask.TestStruct, %Options.ListOpts{
        per_page: 5,
        page: 1,
        sort: "-created",
        expand: "author"
      })

    # dbg(hd(res.body.items))
    assert res.status == 200
    assert length(res.body.items) == 5
    assert res.body.page == 1
  end
end
