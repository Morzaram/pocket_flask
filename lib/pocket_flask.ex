defmodule PocketFlask do
  @moduledoc """
  Documentation for `PocketFlask`.
  """

  defdelegate create(collection_name, data, item_struct, opts), to: PocketFlask.Create
  defdelegate create(collection_name, data, item_struct), to: PocketFlask.Create
  defdelegate create!(collection_name, data, item_struct, opts), to: PocketFlask.Create
  defdelegate create!(collection_name, data, item_struct), to: PocketFlask.Create
  defdelegate get_list(collection_name, item_struct, opts), to: PocketFlask.GetList
  defdelegate get_list(collection_name, item_struct), to: PocketFlask.GetList
  defdelegate get_list!(collection_name, item_struct, opts), to: PocketFlask.GetList
  defdelegate get_list!(collection_name, item_struct), to: PocketFlask.GetList
  defdelegate get_struct_list(collection_name, item_struct, opts), to: PocketFlask.GetList
  defdelegate get_struct_list(collection_name, item_struct), to: PocketFlask.GetList
  defdelegate get_struct_list!(collection_name, item_struct, opts), to: PocketFlask.GetList
  defdelegate get_struct_list!(collection_name, item_struct), to: PocketFlask.GetList
  defdelegate get_one(collection_name, id, item_struct, opts), to: PocketFlask.GetOne
  defdelegate get_one(collection_name, id, item_struct), to: PocketFlask.GetOne
  defdelegate get_one!(collection_name, id, opts), to: PocketFlask.GetOne
  defdelegate get_one!(collection_name, id), to: PocketFlask.GetOne
  defdelegate get_struct_one(collection_name, id, item_struct, opts), to: PocketFlask.GetOne
  defdelegate get_struct_one(collection_name, id, item_struct), to: PocketFlask.GetOne
  defdelegate get_struct_one!(collection_name, id, item_struct, opts), to: PocketFlask.GetOne
  defdelegate get_struct_one!(collection_name, id, item_struct), to: PocketFlask.GetOne
  defdelegate update(collection_name, id, data, item_struct, opts), to: PocketFlask.Update
  defdelegate update(collection_name, id, data, item_struct), to: PocketFlask.Update
  defdelegate update!(collection_name, id, data, item_struct, opts), to: PocketFlask.Update
  defdelegate update!(collection_name, id, data, item_struct), to: PocketFlask.Update
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
    {form, params} =
      prepare_params(params)
      |> Map.split([:filter])

    Req.new(
      base_url: "#{@base_url}/collections/",
      params: params,
      max_retries: @max_retries
    )
  end

  @spec get_token(String.t(), String.t()) :: any()
  def get_token(email, password) do
    {:ok, token} = PocketFlask.Authenticate.auth_with_password(~c"admins", email, password)
  end

  @doc """
  Takes incoming stuct and converts it into query parameters
  """
  @spec prepare_params(map()) :: map()
  def prepare_params(params) do
    cond do
      is_struct(params) -> Map.from_struct(params)
      is_map(params) && !is_struct(params) -> params
    end
    |> KeyConvert.camelize()
    |> Enum.filter(fn {_, v} -> v != nil end)
    |> Enum.into(%{})
  end

  @doc """
  This handles non '!' responses from the Pocketbase requests
  """
  def format_response(res, struct) when is_tuple(res) do
    case res do
      {:ok, %{status: 200} = res} -> {:ok, snaked_struct(struct, res)}
      {:ok, %{status: 204} = res} -> {:ok, snaked_struct(struct, res)}
      {:ok, res} -> {:ok, snaked_struct(Res.ErrorRes, res)}
      {:error, err} -> {:error, err}
    end
  end

  @doc """
  This handles '!' responses from the Pocketbase requests
  """
  def format_response(res, struct) when is_struct(res) do
    case res do
      %{status: 200} = res -> snaked_struct(struct, res)
      res when is_struct(res) -> struct(Res.ErrorRes, Map.from_struct(res))
    end
  end

  @doc """
  This function is used to handle structuring an error response.
  """

  @spec convert_to_structs(%Res.ErrorRes{}, any) :: %Res.ErrorRes{}
  def convert_to_structs(%Res.ErrorRes{} = res, item_struct) do
    res
  end

  @doc """
  This function is used to handle structuring a non-error and non '!' response.
  """

  @spec convert_to_structs(tuple(), struct()) :: tuple()
  def convert_to_structs({status, res}, item_struct) do
    {status, convert_to_structs(res, item_struct)}
  end

  @doc """
  This function is used to handle structuring a non-error and '!' response.
  """
  @spec convert_to_structs(struct(), any) :: struct()
  def convert_to_structs(res, item_struct) do
    res
    |> Map.replace_lazy(:body, fn body ->
      case body do
        %{items: items} -> Map.put(body, :items, parse_items(items, item_struct))
        _ -> Nestru.decode_from_map!(body, item_struct)
      end
    end)
  end

  def parse_items(items, struct) do
    Enum.map(items, fn item -> Nestru.decode_from_map!(item, struct) end)
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
