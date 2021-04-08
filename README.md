# README

* Ruby Backend API for the CodingChallengeRubyBackend.

* Requirements This application uses Ruby version 2.7.2 To install, use rvm or rbenv.

* RVM

`rvm install 2.7.2`

`rvm use 2.7.2`

* Rbenv

`rbenv install 2.7.2`

* Bundler Bundler provides a consistent environment for Ruby projects by tracking and installing the exact gems and versions that are needed I recommend bundler version 2.0.2. To install:


* You need Rails. The rails version being used is rails version 6

* To install:

`gem install rails -v '~> 6'` 

* Installation To get up and running with the project locally, follow the following steps.

* Clone the app

* With SSH

`git@github.com:Mutuba/CodingChallengeRubyBackend.git`

* With HTTPS

`https://github.com/Mutuba/CodingChallengeRubyBackend.git`


* Move into the directory and install all the requirements.

* cd CodingChallengeRubyBackend

* check out to master branch

* run `bundle install` to install application packages

* Run `rails db:create` to create a databse for the application

* Run `rails db:migrate` to run database migrations and create database tables

* The application can be run by running the below command:-

`rails s` or `rails server`

* The application has tests as it was implemented using TDD.

* To run tests, run the following command:-

` bundle exec rspec`

* This will show test coverage when all tests have run.

* Example:

`/Users/mutuba/Desktop/projects/CodingChallenge/tasks-api/public/coverage. 210 / 223 LOC (94.17%) covered.`

* The API has been hosted on heroku and can be found on this url: `https://ruby-backend-code-challenge.herokuapp.com`

* To create a task, make a POST request with the payload below to `https://ruby-backend-code-challenge.herokuapp.com/api/v1/tasks/` 

```
{
    "description" : "Finish up on doing makeup",
    "avatar" : "mutuba.png",
    "finished" : false

}
```
* The payload should be sent as `FormData` in Postman client

* To list all tasks created, make a get request to `https://ruby-backend-code-challenge.herokuapp.com/api/v1/tasks/`

* To get a task by id amke a get request to `https://ruby-backend-code-challenge.herokuapp.com/api/v1/tasks/{task_id}` passing in `task_id` as the id of the task you with to view.

* To update a task, make a PUT request to `https://ruby-backend-code-challenge.herokuapp.com/api/v1/tasks/{task_id}` passing in `task_id` as the id of the task you wish to update