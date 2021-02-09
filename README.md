# README

# Test API Rails
Rin Nadia's Test Submission

## Additional Installed Gems
**Knock**:
For creating and authentication based on JWT

**rspec-rails**:
For creating and running unit tests.

**carrierwave**:
For uploading image.

## Any References for Implementation?
Since this is my first using ruby and rails, I uses many sources for learning.
Mostly, I see Youtube video tutorials, Medium articles, Ruby and Rails documentations 
and people repository during these 7 days.

## Reasons for mMking Modifications to API Documentation or The Requirements Itself

I didn't do many modification toward API documentation explicitly. 
I've tried my best to follow the spec. 
So far, my API application can retrieve the exact request from the API Documentation. 
But, I just add additional column to the content table (In "create content" case). I add "projectID" as the reference to the project 
which the content belongs to. Before executing query, the parameters are modified so that there is "projectId" inside. Then, for creating and editing project,
I need to modify "type" key on the request parameter, because "type" is reserved word. 

## How to get this server running?
**After cloning or retrieving this code, it's recommended to open this with IDE.**

**First step, install all gems.**

```console
bundle install
```
**Second, migrate the database.**

```console
rails db:migrate
```

**Third, run the development server.**

```console
rails s
```
**(Additional) Fourth, stop the development server.**

```console
ctrl+c
```

## Unfinished Parts for This API Server?
**unit test with Rspec**:
From all cases I wrote, only one is able to execute successfully. 

**DB Seed**:
From three tables, only Project table that is empty after executing the seed file. 
