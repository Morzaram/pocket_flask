defmodule PocketFlask.Update do
  alias Options.UpdateOpts
  import PocketFlask

  @spec url(String.t(), String.t()) :: <<_::64, _::_*8>>
  def url(collection, id), do: "#{collection}/records/#{id}"

  @spec update(String.t(), String.t(), map(), UpdateOpts.t()) ::
          {:ok, struct()} | {:error, struct()}
  def update(collection_name, id, data, opts \\ %UpdateOpts{}) do
    rest_req(opts)
    |> Req.patch(url: url(collection_name, id), json: data)
    |> handle_response(Res.UpdateRes)
  end

  @spec update!(String.t(), String.t(), map(), UpdateOpts.t()) ::
          {:ok, struct()} | {:error, struct()}
  def update!(collection_name, id, data, opts \\ %UpdateOpts{}) do
    rest_req(opts)
    |> Req.patch!(url: url(collection_name, id), json: data)
    |> handle_response(Res.UpdateRes)
  end
end
