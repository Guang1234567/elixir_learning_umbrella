# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

import_config "#{Mix.env()}.exs"

config :datasets,
  ecto_repos: [Friends.Repo]

config :datasets, Friends.Repo,
  database: System.get_env("database"),
  username: System.get_env("username"),
  password: System.get_env("password"),
  hostname: System.get_env("hostname"),
  port: System.get_env("port")

# Sample configuration:
#
#     config :logger, :console,
#       level: :info,
#       format: "$date $time [$level] $metadata$message\n",
#       metadata: [:user_id]
#
