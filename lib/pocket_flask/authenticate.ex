defmodule PocketFlask.Authenticate do
  alias Options.AuthOpts
  import PocketFlask

  def auth_with_password(collection_name, email, password) do
    url = "/#{collection_name}/auth-with-password"

    base_req()
    |> Req.post!(url: url, json: %{identity: email, password: password})
    |> format_response(Res.AuthWithPasswordRes)
  end

  def get_token(response) do
    case response do
      {:ok, %{body: %{"token" => token}}} -> token
      %{body: %{"token" => token}} -> token
      {:error, err} -> err
    end
  end

  defp base_req(params \\ %{}) do
    Req.new(
      base_url: "#{Constants.base_url()}",
      params: params,
      max_retries: Constants.max_retries()
    )
  end
end
