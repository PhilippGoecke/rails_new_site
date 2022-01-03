rbenv local 3.0.3

gem install rails

rails new . --css=bootstrap --database=sqlite3 #--force

rails generate controller welcome index

sed -i 's/end/  root "welcome#index"\nend/g' config/routes.rb

#rails assets:precompile

rails server -b 0.0.0.0 -p 3000
