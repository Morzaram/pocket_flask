defmodule Res.GetOneRes do
  @derive Nestru.Decoder
  defstruct [
    :status,
    :headers,
    :body,
    :private
  ]

  @type t :: %__MODULE__{
          status: integer(),
          headers: [{String.t(), String.t()}],
          body: map(),
          private: map()
        }
end
