defmodule PocketFlask do
  @moduledoc """
  Documentation for `PocketFlask`.
  """
  alias Options.{CreateOpts, ListOpts, OneOpts, UpdateOpts}

  defdelegate create(collection_name, data, item_struct, opts \\ %CreateOpts{}),
    to: PocketFlask.Create

  defdelegate create!(collection_name, data, item_struct, opts \\ %CreateOpts{}),
    to: PocketFlask.Create

  defdelegate get_list(collection_name, opts \\ %ListOpts{}), to: PocketFlask.GetList

  defdelegate get_list!(collection_name, opts \\ %ListOpts{}),
    to: PocketFlask.GetList

  defdelegate get_struct_list(collection_name, item_struct, opts \\ %ListOpts{}),
    to: PocketFlask.GetList

  defdelegate get_struct_list!(collection_name, item_struct, opts \\ %ListOpts{}),
    to: PocketFlask.GetList

  defdelegate get_one(collection_name, id, opts \\ %OneOpts{}),
    to: PocketFlask.GetOne

  defdelegate get_one!(collection_name, id, opts \\ %OneOpts{}),
    to: PocketFlask.GetOne

  defdelegate get_struct_one(collection_name, id, item_struct, opts \\ %OneOpts{}),
    to: PocketFlask.GetOne

  defdelegate get_struct_one!(collection_name, id, item_struct, opts \\ %OneOpts{}),
    to: PocketFlask.GetOne

  defdelegate update(collection_name, id, data, opts \\ %UpdateOpts{}), to: PocketFlask.Update
  defdelegate update!(collection_name, id, data, opts \\ %UpdateOpts{}), to: PocketFlask.Update
  defdelegate delete(collection_name, id), to: PocketFlask.Delete
  defdelegate delete!(collection_name, id), to: PocketFlask.Delete

  @max_retries Application.compile_env(:pocket_flask, :retry_count)
  @base_url Application.compile_env(:pocket_flask, :rest_url)
  @email System.get_env("PB_ADMIN_EMAIL")
  @password System.get_env("PB_ADMIN_PASSWORD")
  @doc """
  Documentation for `RestUrl`.
  """

  @spec rest_req(map()) :: Req.Request.t()
  def rest_req(params \\ %{}) do
    params =
      cond do
        is_struct(params) -> Map.from_struct(params)
        true -> params
      end

    {form, params} = Map.split(params, [:filter])

    Req.new(
      base_url: "#{@base_url}/collections/",
      form: form,
      params: params,
      max_retries: @max_retries
    )
  end

  def get_token(email, password) do
    {:ok, token} = PocketFlask.Authenticate.auth_with_password('admins', @email, @password)
  end

  @spec purge_unused_params(struct()) :: list()
  def purge_unused_params(opts) do
    opts
    |> Map.from_struct()
    |> KeyConvert.camelize()
    |> Enum.filter(fn {_, v} -> v != nil end)
  end

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

  @spec structure_items(tuple(), struct()) :: tuple()
  def structure_items({status, res}, item_struct) do
    {status, structure_items(res, item_struct)}
  end

  @spec structure_items(struct(), any) :: struct()
  def structure_items(res, item_struct) do
    res
    |> Map.replace_lazy(:body, fn body ->
      case body do
        %{items: items} -> parse_items(items, item_struct)
        _ -> body |> parse_body(item_struct)
      end
    end)
  end

  def parse_items(items, struct) do
    Enum.map(items, fn item -> Nestru.decode_from_map!(item, struct) end)
  end

  def parse_body(item, struct) do
    Nestru.decode_from_map!(item, struct)
  end

  def body_only(res) do
    Map.get(res, :body)
  end

  def items_only({:ok, res}) do
    items_only(res)
  end

  def items_only(res) do
    case Map.get(res, :body) do
      %{items: items} -> items
      _ -> Map.get(res, :body)
    end
  end

  defp snaked_struct(struct, res) do
    Map.from_struct(res)
    |> KeyConvert.snake_case()
    |> Nestru.decode_from_map!(struct)
  end
end
