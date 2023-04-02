defmodule PocketFlask.GetOne do
  alias Options.OneOpts
  import PocketFlask

  def get_one(collection_name, id, opts \\ %OneOpts{}) do
    case Req.get(get_one_url(collection_name, id)) do
      {:ok, %{status: 200} = res} -> {:ok, struct(Res.GetOneRes, Map.from_struct(res))}
      {:ok, res} -> {:ok, struct(Res.ErrorRes, Map.from_struct(res))}
      {:error, err} -> {:error, err}
    end
  end

  def get_one!(collection_name, id, opts \\ %OneOpts{}) do
    case Req.get!(get_one_url(collection_name, id)) do
      %{status: 200} = res -> struct(Res.GetOneRes, Map.from_struct(res))
      res -> struct(Res.ErrorRes, Map.from_struct(res))
    end
  end

  defp get_one_url(collection_name, id, opts \\ %OneOpts{}) do
    "#{rest_url()}/collections/#{collection_name}/records/#{id}"
  end
end
