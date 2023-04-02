defmodule PocketFlask do
  @moduledoc """
  Documentation for `PocketFlask`.
  """
  alias Options.{CreateOpts, ListOpts, OneOpts, UpdateOpts}
  defdelegate create(collection_name, data, opts \\ %CreateOpts{}), to: PocketFlask.Create
  defdelegate create!(collection_name, data, opts \\ %CreateOpts{}), to: PocketFlask.Create
  defdelegate get_list(collection_name, opts \\ %ListOpts{}), to: PocketFlask.GetList
  defdelegate get_list!(collection_name, opts \\ %ListOpts{}), to: PocketFlask.GetList
  defdelegate get_one(collection_name, id, opts \\ %OneOpts{}), to: PocketFlask.GetOne
  defdelegate get_one!(collection_name, id, opts \\ %OneOpts{}), to: PocketFlask.GetOne
  defdelegate update(collection_name, id, data, opts \\ %UpdateOpts{}), to: PocketFlask.Update
  defdelegate update!(collection_name, id, data, opts \\ %UpdateOpts{}), to: PocketFlask.Update
  defdelegate delete(collection_name, id), to: PocketFlask.Delete
  defdelegate delete!(collection_name, id), to: PocketFlask.Delete

  @doc """
  Documentation for `RestUrl`.
  """

  def rest_url, do: Application.fetch_env!(:pocket_flask, :rest_url)

  @spec rest_req(struct) :: Req.Request.t()
  def rest_req(params \\ %{}) do
    params = if is_struct(params), do: purge_unused_params(params), else: []

    Req.new(
      base_url: "#{rest_url()}/collections/",
      params: params,
      cache: true
    )
  end

  def purge_unused_params(opts) do
    opts
    |> Map.from_struct()
    |> KeyConvert.camelize()
    |> Enum.filter(fn {_, v} -> v != nil end)
  end

  @spec handle_response(any, struct) :: {:ok, struct} | {:error, any}
  def handle_response(res, struct) when is_tuple(res) do
    case res do
      {:ok, %{status: 200} = res} -> {:ok, snaked_struct(struct, res)}
      {:ok, %{status: 204} = res} -> {:ok, snaked_struct(struct, res)}
      {:ok, res} -> {:ok, snaked_struct(Res.ErrorRes, res)}
      {:error, err} -> {:error, err}
    end
  end

  def handle_response(res, struct) when is_struct(res) do
    case res do
      %{status: 200} = res -> snaked_struct(struct, res)
      res -> struct(Res.ErrorRes, Map.from_struct(res))
    end
  end

  defp snaked_struct(struct, res) do
    # dbg()
    Map.from_struct(res) |> KeyConvert.snake_case() |> Nestru.decode_from_map!(struct)
  end
end
