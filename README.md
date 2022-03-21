# Lab Assignment #3
**Names:** (write your name(s) here)

## Introduction

This third lab assignment will be graded and you will be working in pairs, so you can team up with a peer to start working on it. We expect from you to only be working with your peer and avoid exchanging code with others during the lab.

You will be working with the ActiveRecord Object-Relational Mapping (ORM) framework to implement the model layer of a web application. By the end of the assignment, you are required to submit a working Ruby on Rails application containing the model layer, that is, all models and associations.

## First Steps

The starter code contains a Rails project that has a few changes after its original creation. You may open the project with VSCode, with RubyMine, or even use a text-based editor like Vim. If you work on the terminal, always remember to set the correct version of ruby and gemset using RVM:

```sh
rvm use 3@webtech # this will work on the course's VM
````

If you take a look at the `db` directory, you will find there are two files:

* `schema.rb`: This file is automatically created by Rails when migrations are run. The file contains all DDL operations needed to initialize the database schema according to migrations.
* `seeds.rb`: It contains Ruby code that performs initialization in the database. You will see that a series of beers are created in the database.

Now, if you also take a look at `db/migrate`, you will see there is a single migration that creates an `events` table in the database. This table corresponds, of course, to the `Event` model. To see the current columns of the `events` table (and attributes of the `Event` model), one possibility is to take a look at `schema.rb` and have a look at the columns that are added to the `events` table on initialization. 

## Where fun begins

You will create the data model for a web application that implements a ticket sales system. Systems of such kind usually present the user an event catalog, and the user reviews event information and purchases tickets.

* [1.0 point] Start by creating a `Customer` model with `first_name`, `last_name`, `email`, `phone`, `password` and `address` fields. Make the address `string` type.
* [1.5 point] Create an `EventVenue` model with `name`, `address` and `capacity` (integer) attributes. Note than an `EventVenue` _has many_ events. And that an `Event` may _belong to_ an `EventVenue`. When adding a `belongs_to :event_venue` call to `Event`, pass the `optional: true` argument:

```ruby
belongs_to :event_venue, optional:true
```

This will allow an `Event` to be created without specifying an `EventVenue`.
* [1.0 point] Make an `Event` be able to reference an `EventVenue`. For this, a foreign key to the `event_venues` table must be added to the `event` table:
```sh
rails g migration AddEventVenueRefToEvent event_venue:references
```
Look at the migration that is generated with the above command line and make sure it adds a foreign key column to the `events` table.

```ruby
add_reference :events, :event_venue, null: false, foreign_key: true
```

* [1.5 point] Create a `TicketType` model that references an `Event`, has a price (integer) and a `name`. An `Event` _has many_ ticket types.
* [1.0 point] With your models it must be possible to create in the console the following models:
  * Two customers,
  * Three different venues,
  * Two different events (each referencing a different event venue), 
  * Two ticket types per event (e.g. general and golden).

You may edit the file `db/seeds.rb` (this file is intended for database initialization, as we will see in the next class) and add all the code necessary to create the above models (i.e., the same code you enter in the rails console). To run your code, enter the following command:

```sh
$rails db:seed
```

All migrations need to be run before executing the command above!
  
It can be convenient to first sketch an E-R diagram (on paper or with a visual tool) that facilitates analyzing what the necessary models and associations are. You are not required to hand in your diagram though.

## Grading

Each of the three parts of the assignment will be graded on a scale from 1 to 5. The criteria for each score is as follows:

* Not implemented.
* Some very basic implementation is attempted, or the implementation is fundamentally flawed.
* The implementation is either incomplete, does not follow conventions or it is flawed to a considerable extent.
* The implementation is rather complete, but there are issues.
* The implementation is complete and correct.

Then each 1-5 score will translate to 0, 0.25, 0.5, 0.75 and 1.0 weights that will multiply the maximum score possible in the corresponding part of the assignment. The weighted scores will be added up with the base point to calculate the final grade on a scale from 1 to 7.

Please commit and push your code to GitHub until tomorrow (Wednesday 23rd) at 23:59.

## Repository setup

This repository contains a working blank Rails application. You are expected to complete it according to the abovelisted requirements.

Remember to use rvm to work with your project.

```sh
# Execute the folling commands from within the lab assignment directory:
$rvm use 3.1.1@webtech # that is, supposing you are using the course's VM with the webtech gemset.
$bundle install
$rails c
```

The last command in the listing above will open the Rails console for you. You may close it with Ctrl+D.

## About migrations

* Migrations that you create by using the rails generator can be modified by hand. You may do so in case you misstype column names, or types. If you need to modify a migration by hand, delete the database (run `db:drop`) (see below about database tasks), and start over recreating the database.

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

* [Command line](http://guides.rubyonrails.org/command_line.html)
* [Active Record Basics](http://guides.rubyonrails.org/active_record_basics.html)
* [Active Record Model](http://api.rubyonrails.org/classes/ActiveModel/Model.html)
* [Basic Models Associations](http://guides.rubyonrails.org/association_basics.html)
* [Active Record Association Methods](http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html)
* [Active Record Migrations](http://edgeguides.rubyonrails.org/active_record_migrations.html)
