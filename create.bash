rbenv local 3.0.3

gem install rails

rails new . --css=bootstrap --database=sqlite3 #--force

rails generate controller welcome index

sed -i 's/end/\n  root to: "welcome#index"\nend/g' config/routes.rb

bundle add devise
rails generate devise:install
sed -i 's/\nend/\n\n  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }\nend/g' config/environments/development.rb
rails generate devise user
rails db:migrate

rails server -b 0.0.0.0 -p 3000
