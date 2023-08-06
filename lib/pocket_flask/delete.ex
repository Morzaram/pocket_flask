defmodule PocketFlask.Delete do
  import PocketFlask

  @spec url(String.t(), String.t()) :: <<_::64, _::_*8>>
  def url(collection, id), do: "#{collection}/records/#{id}"

  @spec delete(String.t(), String.t()) :: {:ok, struct()} | {:error, struct()}
  def delete(collection_name, id) do
    rest_req() |> Req.delete(url: url(collection_name, id)) |> format_response(Res.DeleteRes)
  end

  @spec delete!(String.t(), String.t()) :: {:ok, struct()} | {:error, struct()}
  def delete!(collection_name, id) do
    rest_req() |> Req.delete!(url: url(collection_name, id)) |> format_response(Res.DeleteRes)
  end
end
