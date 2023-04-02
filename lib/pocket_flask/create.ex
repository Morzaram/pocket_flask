defmodule PocketFlask.Create do
  alias Options.CreateOpts
  import PocketFlask

  def create(collection_name, data, opts \\ %CreateOpts{}) do
    case Req.post(create_url(collection_name, opts), json: data) do
      {:ok, %{status: 200} = res} -> {:ok, struct(Res.CreateRes, Map.from_struct(res))}
      {:ok, res} -> {:ok, struct(Res.ErrorRes, Map.from_struct(res))}
      {:error, err} -> {:error, err}
    end
  end

  @spec create!(String.t(), map(), CreateOpts.t()) :: Res.CreateRes.t()
  def create!(collection_name, data, opts \\ %CreateOpts{}) do
    case Req.post!(create_url(collection_name, opts), json: data) do
      %{status: 200} = res -> struct(Res.CreateRes, Map.from_struct(res))
      res -> struct(Res.ErrorRes, Map.from_struct(res))
    end
  end

  defp create_url(collection_name, opts \\ %CreateOpts{}) do
    "#{rest_url()}/collections/#{collection_name}/records"
  end
end
