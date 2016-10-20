require 'sinatra'
class ApplicationController < Sinatra::Base
  use Rack::MethodOverride
  set :views, File.expand_path('../../views', __FILE__)
  set :public_folder, 'public'
  get '/' do
    erb :'welcome/index.html'
  end
end
