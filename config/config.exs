# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :phoenix_trello,
  ecto_repos: [PhoenixTrello.Repo]

# Configures the endpoint
config :phoenix_trello, PhoenixTrello.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uPMMuiU5IyQCT+jy+al0974LXKDXg9/tVmEZJIR0IapmdrKIZgX6vNe3lUXwDIm5",
  render_errors: [view: PhoenixTrello.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhoenixTrello.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures Guardian
config :guardian, Guardian,
  issuer: "PhoenixTrello",
  ttl: { 3, :days },
  verify_issuer: true,
  secret_key: "SR0yzTcDweBW9BJVUw8YVZ80pBJ7KB3f",
  serializer: PhoenixTrello.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
