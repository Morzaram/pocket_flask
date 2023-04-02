defmodule PocketFlask.Delete do
  import PocketFlask

  def url(collection, id), do: "#{collection}/records/#{id}"

  def delete(collection_name, id) do
    rest_req() |> Req.delete(url: url(collection_name, id)) |> handle_response(Res.DeleteRes)
  end

  def delete!(collection_name, id) do
    rest_req() |> Req.delete!(url: url(collection_name, id)) |> handle_response(Res.DeleteRes)
  end
end
