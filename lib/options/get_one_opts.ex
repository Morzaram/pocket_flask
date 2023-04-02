defmodule Options.OneOpts do
  defstruct [
    :expand
  ]

  @type t :: %__MODULE__{
          expand: String.t() | nil
        }
end
