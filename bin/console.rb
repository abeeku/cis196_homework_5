#!/usr/bin/env ruby
require 'active_record'
base_path = File.expand_path('../..', __FILE__)

require "#{base_path}/environment"
require "#{base_path}/database"

Dir["#{base_path}/app/models/*.rb"].each { |f| require_relative f }
Dir["#{base_path}/app/controllers/*.rb"].each { |f| require_relative f }

require 'pry'
Pry.start
