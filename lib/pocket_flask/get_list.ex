defmodule PocketFlask.GetList do
  alias Options.ListOpts
  import PocketFlask

  def url(collection), do: "#{collection}/records"

  def get_list(collection_name, opts \\ %ListOpts{}) do
    rest_req(opts) |> Req.get(url: url(collection_name)) |> handle_response(Res.GetListRes)
  end

  def get_list!(collection_name, opts \\ %ListOpts{}) do
    rest_req(opts) |> Req.get!(url: url(collection_name)) |> handle_response(Res.GetListRes)
  end
end
