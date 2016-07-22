#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
envsubst < ${DIR}/config/database_template.yml > ${DIR}/config/database.yml

bundle exec rake redmine:backlogs:install
rake generate_secret_token
rails server -b 0.0.0.0
