defmodule PocketFlask.GetList do
  alias Options.ListOpts
  import PocketFlask

  def get_list(collection_name, opts \\ %ListOpts{}) do
    case Req.get(get_list_url(collection_name)) do
      {:ok, %{status: 200} = res} -> {:ok, struct(Res.GetListRes, Map.from_struct(res))}
      {:ok, res} -> {:ok, struct(Res.ErrorRes, Map.from_struct(res))}
      {:error, err} -> {:error, err}
    end
  end

  def get_list!(collection_name, opts \\ %ListOpts{}) do
    case Req.get!(get_list_url(collection_name)) do
      %{status: 200} = res -> struct(Res.GetListRes, Map.from_struct(res))
      res -> struct(Res.ErrorRes, Map.from_struct(res))
    end
  end

  defp get_list_url(collection_name) do
    "#{rest_url()}/collections/#{collection_name}/records"
  end
end
