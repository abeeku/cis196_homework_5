ENV['REDDIT_ENV'] ||= 'development'
require 'bundler'
Bundler.require(:default, ENV['REDDIT_ENV'])
require_relative 'environment'
require_relative 'database'
require './app/controllers/application_controller.rb'
Dir.glob('./app/{controllers,models}/*.rb').each { |file| require file }

use PostsController
use CommentsController
run ApplicationController
