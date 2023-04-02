defmodule PocketFlask.Update do
  alias Options.UpdateOpts
  import PocketFlask

  def url(collection, id), do: "#{collection}/records/#{id}"

  def update(collection_name, id, data, opts \\ %UpdateOpts{}) do
    rest_req(opts)
    |> Req.patch(url: url(collection_name, id), json: data)
    |> handle_response(Res.UpdateRes)
  end

  def update!(collection_name, id, data, opts \\ %UpdateOpts{}) do
    rest_req(opts)
    |> Req.patch!(url: url(collection_name, id), json: data)
    |> handle_response(Res.UpdateRes)
  end
end
