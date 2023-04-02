defmodule PocketFlask.GetOne do
  alias Options.OneOpts
  import PocketFlask

  def url(collection, id), do: "#{collection}/records/#{id}"

  def get_one(collection_name, id, opts \\ %OneOpts{}) do
    rest_req(opts) |> Req.get(url: url(collection_name, id)) |> handle_response(Res.GetOneRes)
  end

  def get_one!(collection_name, id, opts \\ %OneOpts{}) do
    rest_req(opts) |> Req.get!(url: url(collection_name, id)) |> handle_response(Res.GetOneRes)
  end
end
