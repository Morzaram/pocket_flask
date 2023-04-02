defmodule PocketFlask.Create do
  alias Options.CreateOpts
  import PocketFlask

  def url(collection), do: "#{collection}/records"

  def create(collection_name, data, opts \\ %CreateOpts{}) do
    rest_req(opts)
    |> Req.post(url: url(collection_name), json: data)
    |> handle_response(Res.CreateRes)
  end

  def create!(collection_name, data, opts \\ %CreateOpts{}) do
    rest_req(opts)
    |> Req.post!(url: url(collection_name), json: data)
    |> handle_response(Res.CreateRes)
  end
end
