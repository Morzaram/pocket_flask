defmodule PocketFlask.GetList do
  alias Options.ListOpts
  import PocketFlask

  def get_list(collection_name, opts \\ %ListOpts{}) do
    {:ok, res} = Req.get(get_list_url(collection_name))
    {:ok, struct(Res.GetListRes, Map.from_struct(res))}
  end

  def get_list!(collection_name, opts \\ %ListOpts{}) do
    res = Req.get!(get_list_url(collection_name))
    struct(Res.GetListRes, Map.from_struct(res))
  end

  defp get_list_url(collection_name) do
    "#{rest_url()}/collections/#{collection_name}/records"
  end
end
