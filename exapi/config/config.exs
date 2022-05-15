# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :exapi,
  ecto_repos: [Exapi.Repo]

# Configures the endpoint
config :exapi, ExapiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "hNZYV3Phi00MIfq7OdpXMSpoNS3euqwYltRJIHdGXsANRhvNpN8jUKuRkRIQzqd7",
  render_errors: [view: ExapiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Exapi.PubSub,
  live_view: [signing_salt: "SZv0KRZO"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :exapi, MyApp.Guardian,
       issuer: "exapi",
       secret_key: "khx8yK5eql76Miv/55G7ouJH4NnCgHPUbT9pER3+R2kJ6zXanpcbmrW2k2Qpu5iW"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
