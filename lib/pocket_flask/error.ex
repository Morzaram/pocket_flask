# {
#   "code": 400,
#   "message": "Something went wrong while processing your request. Invalid filter.",
#   "data": {}
# }

defmodule PocketFlask.Error do
  defstruct [
    :code,
    :message,
    :data
  ]
end
