# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :astman,
  ecto_repos: [Astman.Repo]

# Configures the endpoint
config :astman, AstmanWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1u6MGBQqwdXZLiRVXsFMSqFhVKKV8Wqq8WJm71kEMOAZCaQCmAvbNdGtJIIigr1y",
  render_errors: [view: AstmanWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Astman.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
