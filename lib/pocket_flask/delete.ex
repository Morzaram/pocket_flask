defmodule PocketFlask.Delete do
  import PocketFlask

  def delete(collection_name, id) do
    {:ok, res} = Req.delete(delete_url(collection_name, id))
    {:ok, struct(Res.DeleteRes, Map.from_struct(res))}
  end

  def delete!(collection_name, id) do
    res = Req.delete!(delete_url(collection_name, id))
    struct(Res.DeleteRes, Map.from_struct(res))
  end

  defp delete_url(collection_name, id) do
    "#{rest_url()}/collections/#{collection_name}/records/#{id}"
  end
end
