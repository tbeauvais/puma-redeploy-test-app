# frozen_string_literal: true

threads 2, 5
workers 2

environment 'production'

# enable request logging
quiet false

# when not connecting through nginx or apache use tcp
bind 'tcp://0.0.0.0:3000'

pidfile '/tmp/puma.pid'

# Use “path” as the file to store the server info state. This is
# used by “pumactl” to query and control the server.
state_path './puma.state'

# Start the puma control rack application on “url”.
# This application can be communicated with to control the main server.
# See: pumactl --help
activate_control_app 'auto', { no_token: true }

prune_bundler true

# Needed when using puma-redeploy from a git reference in Gemfile
extra_runtime_dependencies 'puma-redeploy'

plugin :redeploy

redeploy_watch_file './watch_me'

# the number of seconds between checking watch file. defaults to 30.
redeploy_watch_delay 5

# redeploy_debug
