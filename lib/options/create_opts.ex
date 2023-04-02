defmodule Options.CreateOpts do
  defstruct [
    :id,
    :expand
  ]

  @type t :: %__MODULE__{
          id: String.t() | nil,
          expand: String.t() | nil
        }
end
