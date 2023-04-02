defmodule Res.GetListBody do
  @derive Nestru.Decoder
  defstruct [
    :page,
    :per_page,
    :total_pages,
    :total_items,
    :items
  ]

  @type t :: %__MODULE__{
          page: integer(),
          per_page: integer(),
          total_pages: integer(),
          total_items: integer(),
          items: list(map())
        }
end

defmodule Res.GetListRes do
  @derive {Nestru.Decoder, hint: %{body: Res.GetListBody}}
  defstruct [
    :status,
    :headers,
    :body,
    :private
  ]

  @type t :: %__MODULE__{
          status: integer(),
          headers: [{String.t(), String.t()}],
          body: Res.GetListBody.t(),
          private: map()
        }
end
