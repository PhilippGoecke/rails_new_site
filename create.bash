#!/bin/bash

rbenv local 3.0.3

gem install rails #-v 7.0.0

rails new . --css=bootstrap --database=sqlite3 #--force --minimal

rails generate controller welcome index

sed -i 's/end/\n  root to: "welcome#index"\nend/g' config/routes.rb

bundle add devise
rails generate devise:install
sed -i 's/\nend/\n\n  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }\nend/g' config/environments/development.rb
rails generate devise user
rails db:migrate

bundle add cancancan
rails generate cancan:ability

bundle add byebug --group "development, test"

bundle add rubocop --group "development, test"
sed -i '/rubocop/ s/$/, require: false/' Gemfile
bundle add rubocop-rails --group "development, test"
sed -i '/rubocop-rails/ s/$/, require: false/' Gemfile
echo -e "require:\n  - rubocop-rails" >> .rubocop.yml
bundle add rubocop-rspec --group "development, test"
sed -i '/rubocop-rspec/ s/$/, require: false/' Gemfile
echo "  - rubocop-rspec" >> .rubocop.yml
bundle exec rubocop > rubocop.findings

bundle add faker --group "test"

bundle add factory_bot_rails --group "development, test"

bundle add brakeman --group "development, test"
sed -i '/brakeman/ s/$/, require: false/' Gemfile
bundle exec brakeman > brakeman.findings

bundle add bundler-audit --group "development, test"
sed -i '/bundler-audit/ s/$/, require: false/' Gemfile
bundle exec bundler-audit > bundler-audit.findings

bundle add rspec-rails --group "development, test"
rails generate rspec:install
bundle exec rspec

bundle add cucumber-rails --group "development, test"
sed -i '/cucumber-rails/ s/$/, require: false/' Gemfile
bundle add database_cleaner --group "development, test"
rails generate cucumber:install
bundle exec cucumber

rails server -b 0.0.0.0 -p 3000
