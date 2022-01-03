rbenv local 3.0.3

gem install rails

rails new . --css=bootstrap --database=sqlite3 #--force

rails generate controller welcome index

sed -i 's/\nend/\n\n  root to: "welcome#index"\nend/g' config/routes.rb

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
bundle exec rubocop > rubocop.findings

bundle add faker --group "test"

bundle add factory_bot_rails --group "development, test"

bundle add rspec-rails --group "development, test"
rails generate rspec:install
bundle exec rspec

bundle add brakeman --group "development, test"
sed -i '/brakeman/ s/$/, require: false/' Gemfile
bundle exec brakeman > brakeman.findings

bundle add bundler-audit --group "development, test"
sed -i '/bundler-audit/ s/$/, require: false/' Gemfile
bundle exec bundler-audit > bundler-audit.findings

rails server -b 0.0.0.0 -p 3000
