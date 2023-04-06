defmodule PocketFlask.Authenticate do
  alias Options.AuthOpts
  import PocketFlask

  def auth_with_password(collection_name, email, password) do
    url = "/api/collections/#{collection_name}/auth-with-password"

    rest_req()
    |> Req.post!(url: url, json: %{email: email, password: password})
    |> handle_response(Res.AuthWithPasswordRes)
  end

  # def validate_token(collection_name, token) do
  #   url = "/api/collections/#{collection_name}/confirm-verification"

  #   rest_req()
  #   |> Req.post!(url: url, json: %{email: email, password: password})
  #   |> handle_response(Res.AuthWithPasswordRes)
  # end
end
