# Solution to Lab Assignment #5

## Introduction

This fifth lab assignment will be graded and you will be working in pairs, so you can team up with a peer to start working on it. You will continue working on the ticket sales application, now adding a 'has and belongs to many' association, and several model queries.

## First Steps (Don't rush, read this first!)

The starter code contains a Rails project that implements all of the requirements of the previous lab assignment. You may open the project with VSCode, with RubyMine, or even use a text-based editor like Vim. If you use RVM, it should automatically switch to the proper version of ruby with the 'webtech' gemset (see the files `.ruby-version` and `.ruby-gemset` in the root path of your repository). Should you need to set this manually, run the following command:

```sh
rvm use 3@webtech # this will work on the course's VM
````

As in past assignments, if you take a look at the `db` directory, you will find there are two files:

* `schema.rb`: This file is automatically created by Rails when migrations are run. The file contains all DDL operations needed to initialize the database schema according to migrations.
* `seeds.rb`: It contains Ruby code that performs initialization in the database. You will see that a series of beers are created in the database.

In addition to the above, in this assignment the database will be automatically populated with fake models for you to write Active Record queries against. For this to work, follow these steps:

```sh
bundle install # new gems have been added to the Gemfile
rails db:setup
rails db:populate_fake_data # This will generate fake events, customers, etc.
rails c
```

The console will open up and you should be able to experiment with the models that are available.

In case you wonder how models are being created with fake data, have a look at the 
file `RAILS_ROOT/test/factories.rb`. Models are created automatically using a gem
called [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails). Data for the models is provided by the [ffaker](https://github.com/ffaker/ffaker) gem.

The rails/rake task `populate_fake_data` that generates models by calling definitions in `factories.rb` is defined in `RAILS_ROOT/lib/model_queries.rake`.

## Bring 'em on

### Add a HABTM association (1.5 points)

* Add a model called `Organizer`, with `name`, `address`, and `email` fields.
* An `Event` has and belongs to many `Organizer`s, and vice-versa. That is, in simplified relational jargon, an `Event` has many `Organizer`s, and an `Organizer` has many `Event`s.

For the above to work, you must create a junction table for `Organizer`s and `Event`s. The table must be called `events_organizers`. This [post on StackOverflow](https://stackoverflow.com/questions/17765249/generate-migration-create-join-table) will give you further details on generating a migration that creates a junction table. Remember that you may edit migrations by hand, and you may drop the database and recreate it (reapplying all migrations) whenever needed.

Also, add `has_and_belongs_to_many` associations to both `Organizer` and `Event` models. For examples and explanation on this, take a look at [this guide](https://edgeguides.rubyonrails.org/association_basics.html#the-has-and-belongs-to-many-association).

### Model Queries (4.5 points)

You are required to implement the following Active Record model queries in your application:

1. [0.5 point] Report the total number of tickets bought by a given customer. Hint: see the `has_many :through!` association that exists between `Customer` and `Ticket`.
2. [0.5 point] Report the total number of different events that a given customer has attended. That is, write a query that works for any `Customer` object given its model object, or the id.
3. [0.5 point] Names of the events attended by a given customer.
4. [0.5 point] Total number of tickets sold for an event.
5. [0.5 point] Total sales of an event.
6. [1.0 point] The event that has been most attended by women.
7. [1.0 point] The event that has been most attended by men ages 18 to 30.

You may use the rails console to try out your model queries. When you are done with a query, add it to the file `RAILS_ROOT/lib/tasks/model_queries.rake`, where `RAILS_ROOT` is, of course, the root directory of the rails application. In this file, you will see a [rake task(https://www.rubyguides.com/2019/02/ruby-rake/) called `model_queries`. There is a sample query in this task for you to see the style with which we expect you to write your queries.

To try your queries, you may run the following task in the command line:

```sh
rake db:model_queries   
```

If for some reason you would need to rebuild the fake model data in the database, run the following commands:

```sh
rake db:drop && db:setup
rake db:populate_fake_data
```

## Grading

Each of the three parts of the assignment will be graded on a scale from 1 to 5. The criteria for each score is as follows:

* Not implemented.
* Some very basic implementation is attempted, or the implementation is fundamentally flawed.
* The implementation is either incomplete, does not follow conventions or it is flawed to a considerable extent.
* The implementation is rather complete, but there are issues.
* The implementation is complete and correct.

Then each 1-5 score will translate to 0, 0.25, 0.5, 0.75 and 1.0 weights that will multiply the maximum score possible in the corresponding part of the assignment. The weighted scores will be added up with the base point to calculate the final grade on a scale from 1 to 7.

Please commit and push your code to GitHub until tomorrow (Wednesday 6th) at 23:59.

## About migrations

* Migrations that you create by using the rails generator can be modified by hand. You may do so in case you misstype column names, or types. If you need to modify a migration by hand, delete the database (run `db:drop`) (see below about database tasks), and start over recreating the database (run `db:setup`).

## Making sure it all works: The Rails Console

Ruby on Rails provides a console on which you may run ruby code that instances the models contained in your application, and allows you to try out the associations that are implemented. Just to give you an idea about what is possible, consider the following example:

```sh
rails c
> Event.all # Will show all Beer models available
> Event.first # Will show the first event record found
> ev = EventVenue.create(name: bb, capacity: 1000) # Create an event venue
> e = Event.create(...) # This will create an event
> c = Customer.create(...)
```

To quit the console, press Ctrl+D.

## Basic database tasks

Rails provides several database tasks that you may run on the command line whenever needed:

* `db:migrate` runs (single) migrations that have not run yet.
* `db:create` creates the database
* `db:drop` deletes the database
* `db:schema:load` creates tables and columns within the (existing) database following `schema.rb`
* `db:setup` does `db:create`, `db:schema:load`,  `db:seed`
* `db:reset` does `db:drop`, `db:setup`

Typically, you would use db:migrate after having made changes to the schema via new migration files (this makes sense only if there is already data in the database). `db:schema:load` is used when you setup a new instance of your app.

After you create a migration, do not forget to apply it to the database!

```sh
rails db:migrate
```

The following example will drop the current database and then recreate it, including initialization as specified in `db/seeds.rb`:

```sh
rails db:drop
rails db:setup
```

## Useful links

The following links to Rails Guides will provide you useful information for completing your assignment:

* [Command line](http://edgeguides.rubyonrails.org/command_line.html)
* [Active Record Basics](http://edgeguides.rubyonrails.org/active_record_basics.html)
* [Active Record Model](http://api.rubyonrails.org/classes/ActiveModel/Model.html)
* [Basic Models Associations](http://edgeguides.rubyonrails.org/association_basics.html)
* [Active Record Association Methods](http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html)
* [Active Record Migrations](http://edgeguides.rubyonrails.org/active_record_migrations.html)
* [Active Record Validations](https://edgeguides.rubyonrails.org/active_record_validations.html)
* [Active Record Query Interface](https://edgeguides.rubyonrails.org/active_record_callbacks.html)
