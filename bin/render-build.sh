#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails db:setup
bundle exec rails import:all_data:from_csv

