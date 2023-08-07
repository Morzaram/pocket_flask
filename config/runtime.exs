import Config

config :pocket_flask,
  email: System.get_env("PB_ADMIN_EMAIL"),
  password: System.get_env("PB_ADMIN_PASSWORD"),
  admin_token: System.get_env("PB_ADMIN_TOKEN")
