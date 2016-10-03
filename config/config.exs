# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ectoservice,
  ecto_repos: [Ectoservice.Repo]

config :ffmpex, ffmpeg_path: "D:/FFMpeg/bin/ffmpeg"
config :ffmpex, ffprobe_path: "D:/FFMpeg/bin/ffprobe"

# Configures the endpoint
config :ectoservice, Ectoservice.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Asx4MTP7MmYG1r4K+BCQfZITPY8eqbRA/Do1w0nv8RF/x4dO14gzg6hXV7uFdlGM",
  render_errors: [view: Ectoservice.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Ectoservice.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :algolia,
  application_id: "4SEEF4BXUC",
  api_key: "6c0b5acaa20c5cf5a260f643e7cc3b59"

config :ibm_watson,
  username: "62b8fff6-ef18-4fa3-aec8-00fe3ae6b9a0",
  password: "Xof0nKmNW4FG"

config :stripe, secret_key: "sk_test_FgUtCE6x7h1xZ4dH85PqIRbS"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
