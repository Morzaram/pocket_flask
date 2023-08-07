defmodule PocketFlask.Admin do
  import PocketFlask

  def create_admin(email, password) do
    admin_req()
    |> Req.post!(url: "/admins", json: %{email: email, password: password})
    |> format_response(Res.CreateAdminRes)
  end

  @spec admin_req(map()) :: Req.Request.t()
  defp admin_req(params \\ %{}) do
    {form, params} =
      prepare_params(params)
      |> Map.split([:filter])

    Req.new(
      base_url: "#{dbg(Constants.base_url())}",
      params: params,
      headers: ["Authorization", "Bearer #{dbg(Constants.admin_token())}"],
      max_retries: Constants.max_retries()
    )
  end
end
