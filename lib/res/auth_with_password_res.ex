defmodule Res.AuthRecord do
  @derive Nestru.Decoder
  defstruct [
    :id,
    :collectionId,
    :collectionName,
    :username,
    :verified,
    :emailVisibility,
    :email,
    :created,
    :updated,
    :name,
    :avatar
  ]

  @type t :: %__MODULE__{
          id: String.t(),
          collectionId: String.t(),
          collectionName: String.t(),
          username: String.t(),
          verified: false,
          emailVisibility: true,
          email: String.t(),
          created: String.t(),
          updated: String.t(),
          name: String.t(),
          avatar: String.t()
        }
end

defmodule Res.TokenAndAdmin do
  @derive {Nestru.Decoder, hint: %{admin: Res.AuthRecord}}
  defstruct [
    :token,
    :admin
  ]

  @type t :: %__MODULE__{
          token: String.t(),
          admin: Res.AuthRecord.t()
        }
end

defmodule Res.AuthWithPasswordRes do
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
          body: Res.TokenAndAdmin.t(),
          private: map()
        }
end
