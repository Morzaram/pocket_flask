defmodule PocketFlask.Update do
  alias Options.UpdateOpts
  import PocketFlask

  def update(collection_name, id, data, opts \\ %UpdateOpts{}) do
    case Req.patch(update_url(collection_name, id, opts), json: data) do
      {:ok, %{status: 200} = res} -> {:ok, struct(Res.UpdateRes, Map.from_struct(res))}
      {:ok, res} -> {:ok, struct(Res.ErrorRes, Map.from_struct(res))}
      {:error, err} -> {:error, err}
    end
  end

  def update!(collection_name, id, data, opts \\ %UpdateOpts{}) do
    case Req.patch!(update_url(collection_name, id, opts), json: data) do
      %{status: 200} = res -> struct(Res.UpdateRes, Map.from_struct(res))
      res -> struct(Res.ErrorRes, Map.from_struct(res))
    end
  end

  defp update_url(collection_name, id, opts \\ %UpdateOpts{}) do
    "#{rest_url()}/collections/#{collection_name}/records/#{id}"
  end
end
