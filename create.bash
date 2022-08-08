#!/bin/bash

rbenv local 3.0.4

gem install bundler

bundle init
bundle add rails --version 7.0.3.1
bundle install

bundle exec rails new . --force --skip-git --css=bootstrap --database=sqlite3 # --minimal

bundle exec rails about > rails_about.txt

bundle add rails-i18n
sed -i 's/  end/\n    config.i18n.default_locale = :de\n  end/g' config/application.rb

bundle exec rails generate controller welcome index
sed -i 's/end/\n  root to: "welcome#index"\nend/g' config/routes.rb

bundle add devise
bundle exec rails generate devise:install
sed -i 's/\nend/\n\n  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }\nend/g' config/environments/development.rb
bundle exec rails generate devise user
bundle exec rails db:migrate
bundle add devise-security
rails generate devise_security:install

bundle add cancancan
bundle exec rails generate cancan:ability

bundle add byebug --group "development, test"

bundle add rubocop --group "development, test"
sed -i '/rubocop/ s/$/, require: false/' Gemfile
bundle add rubocop-rails --group "development, test"
sed -i '/rubocop-rails/ s/$/, require: false/' Gemfile
echo -e "require:\n  - rubocop-rails" >> .rubocop.yml
bundle add rubocop-rspec --group "development, test"
sed -i '/rubocop-rspec/ s/$/, require: false/' Gemfile
echo "  - rubocop-rspec" >> .rubocop.yml
bundle add rubocop-performance --group "development, test"
sed -i '/rubocop-performance/ s/$/, require: false/' Gemfile
echo "  - rubocop-performance" >> .rubocop.yml
echo "AllCops:\n  NewCops: enable" >> .rubocop.yml
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
bundle exec rails generate rspec:install
bundle exec rspec

bundle add cucumber-rails --group "development, test"
sed -i '/cucumber-rails/ s/$/, require: false/' Gemfile
bundle add database_cleaner --group "development, test"
bundle exec rails generate cucumber:install
bundle exec cucumber

bundle outdated
yarn outdated
yarn audit

bundle exec rails generate scaffold Post title:string content:text active:boolean context:integer
sed -i 's/end/\n  enum context: [:windows, :linux, :osx, :other]\nend/g' app/models/post.rb
sed -i 's/end/\n  validates :title, presence: true, length: { minimum: 5 }\nend/g' app/models/post.rb
sed -i 's/end/\n  scope :only_active, -> { where(active: true) }\nend/g' app/models/post.rb
sed -i 's/<%= form.number_field :context %>/<%= form.select :context, Post.contexts.keys.to_a %>/g' app/views/posts/_form.html.erb
sed -i 's/    </p>/    </p>\n    <hr>\n/g' app/views/posts/index.html.erb
bundle exec rails db:migrate
bundle exec rails generate resource Comment commenter:string body:text post:references
sed -i 's/end/\n  has_many :comments, dependent: :destroy\nend/g' app/models/post.rb
#sed -i 's/belongs_to :post/belongs_to :post, dependent: :destroy/g' app/models/comment.rb
sed -i 's/resources :posts/resources :posts do\n    #collection\n    member do\n      get 'comments'\n    end\n  end\n/g' config/routes.rb

bundle exec rails db:migrate

bundle exec rails server -b 0.0.0.0 -p 3000
