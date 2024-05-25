#!/usr/bin/env bash

bundle install
bundle exec rails db:setup
bundle exec rails import:all_data:from_csv
