defmodule PocketFlask.Update do
  alias Options.UpdateOpts
  import PocketFlask

  @spec url(String.t(), String.t()) :: <<_::64, _::_*8>>
  def url(collection, id), do: "#{collection}/records/#{id}"

  @spec update(String.t(), String.t(), map(), UpdateOpts.t()) ::
          {:ok, struct()} | {:error, struct()}
  def update(collection_name, id, data, item_struct, opts \\ %UpdateOpts{}) do
    rest_req(opts)
    |> Req.patch(url: url(collection_name, id), json: data)
    |> format_response(Res.UpdateRes)
    |> convert_to_structs(item_struct)
  end

  @spec update!(String.t(), String.t(), map(), UpdateOpts.t()) ::
          {:ok, struct()} | {:error, struct()}
  def update!(collection_name, id, data, item_struct, opts \\ %UpdateOpts{}) do
    rest_req(opts)
    |> Req.patch!(url: url(collection_name, id), json: data)
    |> format_response(Res.UpdateRes)
    |> convert_to_structs(item_struct)
  end
end
