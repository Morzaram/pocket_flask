defmodule ErrorTest do
  use ExUnit.Case, async: true

  test "get_one/3 erroring works" do
    assert {:ok, %Res.ErrorRes{}} =
             PocketFlask.get_one("non_existent_collection", "non_existent_id")
  end

  test "get_one!/3 erroring works" do
    assert %Res.ErrorRes{} = PocketFlask.get_one!("non_existent_collection", "non_existent_id")
  end

  test "get_list/2 erroring works" do
    assert {:ok, %Res.ErrorRes{}} = PocketFlask.get_list("non_existent_collection")
  end

  test "get_list!/2 erroring works" do
    assert %Res.ErrorRes{} = PocketFlask.get_list!("non_existent_collection")
  end

  test "update/4 erroring works" do
    assert {:ok, %Res.ErrorRes{}} =
             PocketFlask.update("non_existent_collection", "non_existent_id", %{foo: "bar"})
  end

  test "update!/4 erroring works" do
    assert %Res.ErrorRes{} =
             PocketFlask.update!("non_existent_collection", "non_existent_id", %{foo: "bar"})
  end

  test "delete/2 erroring works" do
    assert {:ok, %Res.ErrorRes{}} =
             PocketFlask.delete("non_existent_collection", "non_existent_id")
  end

  test "delete!/2 erroring works" do
    assert %Res.ErrorRes{} = PocketFlask.delete!("non_existent_collection", "non_existent_id")
  end

  test "create/3 erroring works" do
    assert {:ok, %Res.ErrorRes{}} = PocketFlask.create("non_existent_collection", %{foo: "bar"})
  end

  test "create!/3 erroring works" do
    assert %Res.ErrorRes{} = PocketFlask.create!("non_existent_collection", %{foo: "bar"})
  end
end
