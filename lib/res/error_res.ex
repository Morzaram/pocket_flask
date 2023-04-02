defmodule Res.Error do
  @derive Nestru.Decoder
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
