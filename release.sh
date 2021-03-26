#!/bin/bash

echo "Running Release Tasks"
 RAILS_ENV=production bin/rails db:drop DISABLE_DATABASE_ENVIRONMENT_CHECK=1
echo "Running Migrations"
bundle exec rails db:migrate


echo "Clearing Rails Cache"
bundle exec rails r "Rails.cache.clear"

echo "Removing temp file"
rm -f tmp/pids/server.pid
echo "Done running release.sh"

exec "$@"