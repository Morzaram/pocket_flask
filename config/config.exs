import Config

config :pocket_flask,
  rest_url: "http://127.0.0.1:8090/api",
  max_retries: 0,
  auth_method: :email,
  token_refresh_interval: 70,
  cache: false
