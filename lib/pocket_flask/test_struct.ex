defmodule PocketFlask.TestStruct do
  @derive Nestru.Decoder

  defstruct [
    :id,
    :title,
    :author,
    :body,
    :created,
    :updated,
    :collection_id,
    :collection_name
  ]
end
