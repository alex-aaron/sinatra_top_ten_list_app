### Welcome to Top Tenning

This is a straightforward web application that allows users to create and view top ten lists on a variety of topics. A user can create an account, login and log out of their account. Once logged in, a user can create a top ten list from a set of pre-determined categories. Users can then browse these categories and view all user created lists, select individual lists, and select individual users to view all lists from that user. Once a user has created a list, they have the ability to edit the list content, title, or category as they see fit, and they can delete the list entirely.


## Built With

* [Sinatra](http://sinatrarb.com/) - Sinatra, our web framework
* [sinatra-activerecord](https://github.com/bmizerany/sinatra-activerecord) - Object Relational Mapping
* [sqlite3](https://rubygems.org/gems/sqlite3/versions/1.3.11) - SQL DB gem
* [Corneal](https://github.com/thebrianemory/corneal) - a Sinatra app generator that creates the scafold file directory and configurations.


## Prerequisites

You will need to have Ruby installed on your machine - Linux or Mac.


## Getting Started

* Fork/Clone this repo, and then navigate to the repo directory in your terminal.
* Then, run `bundle install` to install all gem dependencies.
* Run all rake migrations with `rake db:migrate`
* Finally, start up a server using `shotgun` and navigate to the localhost:9393


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cparisi1290/ez-move
