defmodule PocketFlask.GetOne do
  alias Options.OneOpts
  import PocketFlask

  def get_one(collection_name, id, opts \\ %OneOpts{}) do
    {:ok, res} = Req.get(get_one_url(collection_name, id))
    {:ok, struct(Res.GetOneRes, Map.from_struct(res))}
  end

  def get_one!(collection_name, id, opts \\ %OneOpts{}) do
    res = Req.get!(get_one_url(collection_name, id))
    struct(Res.GetOneRes, Map.from_struct(res))
  end

  defp get_one_url(collection_name, id, opts \\ %OneOpts{}) do
    "#{rest_url()}/collections/#{collection_name}/records/#{id}"
  end
end
