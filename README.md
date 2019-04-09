# README
This is a White Label application. It is intended to allow admin users to create subdomains and add HTML templates, JS files and CSS. It is still in it's creational state and therefore most functionality is still being built.

* Running the app
If this is your first time running the application run
`./reset.sh` this will drop, create and run database migrations and then seed the DB.
In another terminal window you have to run `./bin/webpack-dev-server` to compile the javascript for the site
The app makes use of subdomains so in order to do that locally you will have to use lvh.me:3000 to access the application in the browser. Using localhost:3000 you will not be able to access subdomains locally.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization
To initialize a clean Database you can run ./reset.sh from the root directory. This will do a few things so be careful as it is to purge everything. It is an alias for
```ruby
bundle exec rake db:drop
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
rails s -p 4000
```

* How to run the test suite
In order to run the RSpec test suite you will have to run `rspec`

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
