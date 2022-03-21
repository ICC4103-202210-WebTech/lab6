# Lab Assignment #3
**Names:** (write your name(s) here)

## Introduction

This third lab assignment will be graded and you will be working in pairs, so you can team up with a peer to start working on it. We expect from you to only be working with your peer and avoid exchanging code with others during the lab.

You will be working with the ActiveRecord Object-Relational Mapping (ORM) framework to implement the model layer of a web application. By the end of the assignment, you are required to submit a working Ruby on Rails application containing the model layer, that is, all models and associations.

## Requirements

You will create the data model for a web application that implements a ticket sales system. Systems of such kind usually present the user an event catalog, and the user reviews event information and purchases tickets. The data model for the system must comprise the following features:

* Persist customer information as name, last name, email, phone, password and address.
* Persist event venue information as name, address and capacity.
* Persist event information as name, description, start date, and in which an event takes place.
* Persist ticket type information including the event, and the ticket price.
* Persist ticket orders created by a customer, that is, a ticket order by a customer may comprise one or more types of tickets being purchased, and one or more tickets of each type.

You are required to implement the following in your application:

* [2.5 points] Generate the necessary models, either by using the generator that is built into Rails, and/or by hand.
* [2.5 points] Specify the required associations in the different model classes.
* [1.0 point] Try out your models and their associations by running ActiveRecord method calls in the rails console (`rails c`):
  * Create two customers,
  * three different events, 
  * two ticket types per event (e.g. general and golden),
  * three different venues, and 
  * four orders, each containing tickets for two or more events.

It can be convenient to first sketch an E-R diagram (on paper or with a visual tool) that facilitates analyzing what the necessary models and associations are. You are not required to hand in your diagram though.

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

## Grading

Each of the three parts of the assignment will be graded on a scale from 1 to 5. The criteria for each score is as follows:

* Not implemented.
* Some very basic implementation is attempted, or the implementation is fundamentally flawed.
* The implementation is either incomplete, does not follow conventions or it is flawed to a considerable extent.
* The implementation is rather complete, but there are issues.
* The implementation is complete and correct.

Then each 1-5 score will translate to 0, 0.25, 0.5, 0.75 and 1.0 weights that will multiply the maximum score possible in the corresponding part of the assignment. The weighted scores will be added up with the base point to calculate the final grade on a scale from 1 to 7.

Please commit and push your code to GitHub until tomorrow (Wednesday 23rd) at 23:59.

## Testing your application

To test your application, you can use the RoR console (`rails c`) to create instances of your models, associate them and store them in the database.

To open the rails console and create models, try the following:

## Useful links

The following links to Rails Guides will provide you useful information for completing your assignment:

* [Command line](http://guides.rubyonrails.org/command_line.html)
* [Active Record Basics](http://guides.rubyonrails.org/active_record_basics.html)
* [Active Record Model](http://api.rubyonrails.org/classes/ActiveModel/Model.html)
* [Basic Models Associations](http://guides.rubyonrails.org/association_basics.html)
* [Active Record Association Methods](http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html)
* [Active Record Migrations](http://edgeguides.rubyonrails.org/active_record_migrations.html)
