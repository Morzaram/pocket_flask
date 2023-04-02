defmodule PocketFlask.GetList do
  alias Options.ListOpts
  import PocketFlask

  @spec url(String.t()) :: <<_::64, _::_*8>>
  def url(collection), do: "#{collection}/records"

  @spec get_list(String.t(), ListOpts.t()) :: {:ok, struct()} | {:error, struct()}
  def get_list(collection_name, opts \\ %ListOpts{}) do
    rest_req(opts)
    |> Req.get(url: url(collection_name), cache: true)
    |> handle_response(Res.GetListRes)
  end

  @spec get_list!(String.t(), ListOpts.t()) :: {:ok, struct()} | {:error, struct()}
  def get_list!(collection_name, opts \\ %ListOpts{}) do
    rest_req(opts)
    |> Req.get!(url: url(collection_name), cache: true)
    |> handle_response(Res.GetListRes)
  end
end
