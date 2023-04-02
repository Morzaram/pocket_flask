# {
#   "code": 400,
#   "message": "Something went wrong while processing your request. Invalid filter.",
#   "data": {}
# }

defmodule Res.Error do
  defstruct [
    :code,
    :message,
    :data
  ]
end

defmodule Res.ErrorRes do
  @derive {Nestru.Decoder, hint: %{body: Res.Error}}

  defstruct [
    :status,
    :headers,
    :body,
    :private
  ]

  @type t :: %__MODULE__{
          status: integer(),
          headers: [{String.t(), String.t()}],
          body: Res.Error.t(),
          private: map()
        }
end
