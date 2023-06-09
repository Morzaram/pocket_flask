defmodule PocketFlask.GetList do
  alias Options.ListOpts
  import PocketFlask, only: [rest_req: 1, handle_response: 2, structure_items: 2]

  @cache Application.compile_env(:pocket_flask, :retry_count)
  @spec url(String.t()) :: <<_::64, _::_*8>>
  def url(collection), do: "#{collection}/records"

  @spec get_list(String.t(), ListOpts.t()) :: {:ok, struct()} | {:error, struct()}
  def get_list(collection_name, opts \\ %ListOpts{}) do
    rest_req(opts)
    |> Req.get(url: url(collection_name), cache: @cache)
    |> handle_response(Res.GetListRes)
  end

  @spec get_list!(String.t(), ListOpts.t()) :: {:ok, struct()} | {:error, struct()}
  def get_list!(collection_name, opts \\ %ListOpts{}) do
    rest_req(opts)
    |> Req.get!(url: url(collection_name), cache: @cache)
    |> handle_response(Res.GetListRes)
  end

  @spec get_struct_list(String.t(), struct(), ListOpts.t()) ::
          {:ok, struct()} | {:error, struct()}
  def get_struct_list(collection_name, item_struct, opts \\ %ListOpts{}) do
    get_list(collection_name, opts)
    |> structure_items(item_struct)
  end

  @spec get_struct_list!(String.t(), struct(), ListOpts.t()) ::
          {:ok, struct()} | {:error, struct()}
  def get_struct_list!(collection_name, item_struct, opts \\ %ListOpts{}) do
    get_list!(collection_name, opts)
    |> structure_items(item_struct)
  end
end
