defmodule PocketFlask.Create do
  alias Options.CreateOpts
  import PocketFlask

  def create(collection_name, data, opts \\ %CreateOpts{}) do
    {:ok, res} = Req.post(create_url(collection_name, opts), json: data)
    {:ok, struct(Res.CreateRes, Map.from_struct(res))}
  end

  def create!(collection_name, data, opts \\ %CreateOpts{}) do
    res = Req.post!(create_url(collection_name, opts), json: data)
    struct(Res.CreateRes, Map.from_struct(res))
  end

  defp create_url(collection_name, opts \\ %CreateOpts{}) do
    "#{rest_url()}/collections/#{collection_name}/records"
  end
end
