defmodule Res.CreateAdminRes do
  @derive Nestru.Decoder
  defstruct [
    :status,
    :headers,
    :body,
    :private
  ]
end
