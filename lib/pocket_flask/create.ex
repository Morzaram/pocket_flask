defmodule PocketFlask.Create do
  alias Options.CreateOpts
  import PocketFlask

  @spec url(String.t()) :: <<_::64, _::_*8>>
  def url(collection), do: "#{collection}/records"

  @spec create(String.t(), map(), CreateOpts.t()) :: {:ok, struct()} | {:error, struct()}
  def create(collection_name, data, opts \\ %CreateOpts{}) do
    rest_req(opts)
    |> Req.post(url: url(collection_name), json: data)
    |> handle_response(Res.CreateRes)
  end

  @spec create!(String.t(), map(), CreateOpts.t()) :: {:ok, struct()} | {:error, struct()}
  def create!(collection_name, data, opts \\ %CreateOpts{}) do
    rest_req(opts)
    |> Req.post!(url: url(collection_name), json: data)
    |> handle_response(Res.CreateRes)
  end
end
