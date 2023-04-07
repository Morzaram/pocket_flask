defmodule PocketFlask.GetOne do
  alias Options.OneOpts
  import PocketFlask, only: [rest_req: 1, handle_response: 2, structure_items: 2]
  @cache Application.compile_env(:pocket_flask, :retry_count)

  @spec url(String.t(), String.t()) :: <<_::64, _::_*8>>
  def url(collection, id), do: "#{collection}/records/#{id}"

  @spec get_one(String.t(), String.t(), OneOpts.t()) ::
          {:ok, struct()} | {:error, struct()}

  def get_one(collection_name, id, opts \\ %OneOpts{}) do
    rest_req(opts)
    |> Req.get(url: url(collection_name, id), cache: @cache)
    |> handle_response(Res.GetOneRes)
  end

  @spec get_one!(String.t(), String.t(), OneOpts.t()) ::
          {:ok, struct()} | {:error, struct()}

  def get_one!(collection_name, id, opts \\ %OneOpts{}) do
    rest_req(opts)
    |> Req.get!(url: url(collection_name, id), cache: @cache)
    |> handle_response(Res.GetOneRes)
  end

  @spec get_struct_one(String.t(), String.t(), struct(), OneOpts.t()) ::
          {:ok, struct()} | {:error, struct()}

  def get_struct_one(collection_name, id, item_struct, opts \\ %OneOpts{}) do
    get_one(collection_name, id, opts)
    |> structure_items(item_struct)
  end

  @spec get_struct_one!(String.t(), String.t(), struct(), OneOpts.t()) ::
          {:ok, struct()} | {:error, struct()}

  def get_struct_one!(collection_name, id, item_struct, opts \\ %OneOpts{}) do
    get_one!(collection_name, id, opts)
    |> structure_items(item_struct)
  end
end
