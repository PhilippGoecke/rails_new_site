#!/bin/bash

mkdir rails7.0
cd rails7.0

rbenv local 3.1.4

gem install bundler

bundle init
bundle config set --local path vendor/bundle
bundle add rails --version 7.0.8
bundle install

bundle exec rails new . --force --skip-git --css=bootstrap --database=sqlite3 # --minimal

bundle exec rails about > rails_about.txt

bundle add rails-i18n
sed -i 's/  end/\n    config.i18n.default_locale = :de\n  end/g' config/application.rb

bundle exec rails generate controller welcome index
sed -i 's/end/\n  root to: "welcome#index"\nend/g' config/routes.rb

bundle exec rails assets:precompile

RAILS_ENV=production bundle exec rails server -b 0.0.0.0 -p 3000
