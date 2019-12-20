# Sinatra items of note
* Spec test(s) demonstrating passing params and headers to a GET (or POST) request.
* Some runit deployment setup.
* ActiveRecord integration
* Migrations
* Simple environment management.
* Simple authentication.
* RSpec setup (note the .rspec)
# Rails-6 notes
```
$ bundle exec rails new .
$ touch config/boot.rb
$ touch config/environments/test.rb
# Add config.hosts << 'wud-cwalquist01' to config/environments/development.rb
# ...and some other stuff I forgot...getting rid of some gems in Gemfile, for instance...
$ bundle exec rails server -b 0.0.0.0
```
