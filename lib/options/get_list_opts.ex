defmodule Options.ListOpts do
  defstruct [
    :page,
    :per_page,
    :sort,
    :filter,
    :expand
  ]

  @type t :: %__MODULE__{
          page: integer() | nil,
          per_page: integer() | nil,
          sort: String.t() | nil,
          filter: String.t() | nil,
          expand: String.t() | nil
        }
end
