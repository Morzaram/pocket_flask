defmodule Options.ListOpts do
  defstruct [
    :page,
    :per_page,
    :sort,
    :filter,
    :expand
  ]
end
