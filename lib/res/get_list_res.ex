defmodule Res.GetListBody do
  defstruct [
    :page,
    :perPage,
    :totalPages,
    :totalItems,
    :items
  ]

  @type t :: %__MODULE__{
          page: integer(),
          perPage: integer(),
          totalPages: integer(),
          totalItems: integer(),
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
