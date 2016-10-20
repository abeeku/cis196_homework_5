---
layout: default
title: "Homework 5: Reddit Clone"
permalink: /homeworks/homework5/
---

# Homework 5: Reddit Clone
Due **October 13, 2016 at 11:59pm**.

The assignment is available for download [here](cis196_homework_5.zip).

## Before Starting
Be sure to review [lecture 5](//seas.upenn.edu/~cis196/lectures/CIS196-2016f-lecture5.pdf).

## Task
In this homework, you will implement a simplified Reddit with Sinatra. The app will have the same notable features found in Reddit. Similar to the previous homeworks, you can run `ruby bin/console.rb` to test your models. Admittedly, this will be a lot less useful in this homework, so you will have to do a lot more of your testing with `rackup`.

## Models
We have provided `Comment` and `Post` models with basic validations. For this assignment, you will need to link the models together with ActiveRecord associations so that a post can have many comments, and a comment can belong to only one post. In addition, a comment should also belong to a single `parent` and have many `replies`, both of which are class type `Comment`. To define the class name, you may use `class_name` following the association. For example, a comment would `belongs_to :parent, class_name: 'Comment', foreign_key: :comment_id`. (This line of code will suffice for a comment belonging to a parent, but you will have to write the replies association yourself. You will not need to specify a `foreign_key` for the replies association). When a `parent` is destroyed, any `replies` to that parent comment should also be destroyed (look at the `dependent: :destroy` option). However, when a `reply` has been destroyed, the `parent` comment should still remain. In the `Post` class, a post should have many comments, and the comments should be destroyed if the post is destroyed. However, if a comment is destroyed, the post should still remain.

## Gems
`gem install bundler` if you haven't already and run the `bundle` command. This will install all gems listed in your `Gemfile`.

## Controllers

### ApplicationController

#### Index
When a GET request is sent to `/`, render `index.erb` from the welcome folder.

### PostsController

#### Index
When a GET request is sent to `/posts`, render the posts index page with the ordering of the posts set to show the Newest first. The posts should be assigned to the `@posts` instance variable. Also, create another instance variable name `@section` and give it the value of 'Newest'.

#### Newest
When a GET request is sent to `/posts/newest`, redirect the request to `/posts`.

#### Top
When a GET request is sent to `/posts/top`, render the posts index page with the ordering of the posts set to show most commented on posts first. In a similar fashion to the `/posts` route, make sure the posts are assigned to the `@posts` instance variable, and the `@section` variable has the value of `Top`.

#### New
When a GET request is sent to `/posts/new`, render `posts/new.html.erb`.

#### Post
When the new post page is submitted, this method should handle the creation of a new post. Instantiate a new post with the appropriate information and attempt to assign that instance to the `@post` instance variable. If the `@post` is valid, redirect the user back to the post index page. If the new post was not created successfully, render the `posts/new.html.erb` page again, showing the appropriate errors.

#### Show
When a GET request is sent to `/posts/:id`, set the `@post` instance variable to the Post object with the id in params and render the appropriate post show page.

#### Edit
When a GET request is sent to `/posts/:id/edit`, set the `@post` instance variable to the Post object with the id in params and render the appropriate post edit page.

#### Patch
When the edit post page form submits a PATCH request to `/posts/:id`, this route should correctly handle the updates to the post. The routes in the form are already set up for you, so you should focus on how to get ActiveRecord to update a post correctly. Once the post has been updated, redirect the user back to the appropriate post show page.

#### Delete
When a DELETE request is sent to `/posts/:id`, find the appropriate post and delete that post from the database. Then redirect the user back to `/posts`, and the deleted post should no longer show up.

### CommentsController

#### New
When a GET request is sent to `/posts/:post_id/comments/new`, set the `@post` instance variable to the Post object with the post_id in params and render the new comments form. We have provided the `/posts/:post_id/comments/new/:id` route as a freebie. This route contains the same `@post` instance variable, but also assigns an instance variable named `@comment_id` to the id value in `@parent`, and renders the same new comments form.

#### Post
When the new comment page is submitted, create a `Comment` with the submitted description and associate it with the Post identified by `:post_id`. The route should take into account whether or not a `parent_id` was submitted from the form. Then, redirect the user to the correct `Post` show page. We recommend that you perform error-checking, as the forms should properly display validation errors if the submission fails. If the submission does fail, make sure the `@comment_id` and `@parent` instance variables are appropriately assigned, and render the `comments/new.html` page.

#### Edit
When a GET request is sent to `/posts/:post_id/comments/:id/edit`, set the `@comment_to_edit` instance variable to the Comment object with the id in params, set the `@post` instance variable to the Post object with post_id in params, and render the comments edit form.

#### Patch
When the comment edit form is submitted, this route should correctly handle the updates to the comment. The routes in the form are already set up for you, so you should focus on how to get ActiveRecord to update a comment correctly. Once the comment has been udpated, redirect the user back to the appropriate post show page.

#### Delete
When a DELETE request is sent to `/posts/:post_id/comments/:id` (i.e. when the user clicks the "Delete" button associated with a certain comment), delete the comment and redirect the user to the post show page. As with the posts, when you delete a comment that has children, those children should be deleted as well. However, when you delete a child comment, the parent comment should not be deleted.


## Data
In this assignment, the homework uses a persistent SQLite database for development purposes. This means that you will need to create the database and run the migrations in `db/migrate` before starting to work on the assignment. To do this, run the following commands: `rake db:create` and `rake db:migrate`.

To delete the database at any time, run `rake db:drop`.

## Uploading
To submit your homework, call `rake zip` and upload the generated files.zip file. You must `gem install rake` if you haven't done so already to do this.
