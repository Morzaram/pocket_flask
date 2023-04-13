# PocketFlask

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `pocket_flask` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:pocket_flask, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/pocket_flask>.

Installing Pocketbase

```bash
mix deps.get
iex -S mix
> PocketBaseInstaller.download_and_run_pocketbase
```

In your config.exs add the following

```elixir
import Config

config :pocket_flask,
  rest_url: "http://127.0.0.1:8090/api", #your api url
  cache: true, # Cache responses?
  retry_count: 0, # Times to retry requests
  auth_method: :email,
  email: "your@email.com", #Your auth email
  password: "yourpassword", #Your auth password
  token_expiration_time: [14, :days] # This depends on what is set in pocketbase
```
