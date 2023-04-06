import Config

config :pocket_flask,
  rest_url: "http://127.0.0.1:8090/api",
  cache: true,
  retry_count: 0,
  auth_method: :email,
  email: "chris.aa.king@gmail.com",
  password: "chris.aa.king@gmail.com",
  token_expiration_time: [14, :days]
