defmodule PocketFlask.Delete do
  import PocketFlask

  def delete(collection_name, id) do
    case Req.delete(delete_url(collection_name, id)) do
      {:ok, %{status: 200} = res} -> {:ok, struct(Res.DeleteRes, Map.from_struct(res))}
      {:ok, res} -> {:ok, struct(Res.ErrorRes, Map.from_struct(res))}
      {:error, err} -> {:error, err}
    end
  end

  def delete!(collection_name, id) do
    case Req.delete!(delete_url(collection_name, id)) do
      %{status: 200} = res -> struct(Res.DeleteRes, Map.from_struct(res))
      res -> struct(Res.ErrorRes, Map.from_struct(res))
    end
  end

  defp delete_url(collection_name, id) do
    "#{rest_url()}/collections/#{collection_name}/records/#{id}"
  end
end
