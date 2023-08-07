defmodule Constants do
  values = [
    max_retries: Application.compile_env(:pocket_flask, :max_retries),
    base_url: Application.compile_env(:pocket_flask, :rest_url),
    # admin_token: @admin_token,
    # email: @email,
    # password: @password,
    auth_method: Application.compile_env(:pocket_flask, :auth_method),
    token_refresh_interval: Application.compile_env(:pocket_flask, :token_refresh_interval),
    cache: Application.compile_env(:pocket_flask, :cache)
  ]

  for {key, value} <- values do
    def unquote(key)(), do: unquote(value)
  end

  def token_refresh_in_milliseconds() do
    token_refresh_interval() * 1000
  end

  def email, do: Application.get_env(:pocket_flask, :email)
  def password, do: Application.get_env(:pocket_flask, :password)
  def admin_token, do: Application.get_env(:pocket_flask, :admin_token)

  def check_env() do
    if auth_method() == :email do
      if email() == nil, do: raise("PB_ADMIN_EMAIL is not set")
      if password() == nil, do: raise("PB_ADMIN_PASSWORD is not set")
    end
  end
end
