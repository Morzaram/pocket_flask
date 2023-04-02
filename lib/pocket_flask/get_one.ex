defmodule PocketFlask.GetOne do
  alias Options.OneOpts
  import PocketFlask

  @spec url(String.t(), String.t()) :: <<_::64, _::_*8>>
  def url(collection, id), do: "#{collection}/records/#{id}"

  @spec get_one(String.t(), String.t(), OneOpts.t()) :: {:ok, struct()} | {:error, struct()}
  def get_one(collection_name, id, opts \\ %OneOpts{}) do
    rest_req(opts)
    |> Req.get(url: url(collection_name, id), cache: true)
    |> handle_response(Res.GetOneRes)
  end

  @spec get_one!(String.t(), String.t(), OneOpts.t()) :: {:ok, struct()} | {:error, struct()}
  def get_one!(collection_name, id, opts \\ %OneOpts{}) do
    rest_req(opts)
    |> Req.get!(url: url(collection_name, id), cache: true)
    |> handle_response(Res.GetOneRes)
  end
end
