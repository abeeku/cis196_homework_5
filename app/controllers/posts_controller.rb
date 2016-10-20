
class PostsController < ApplicationController
  get '/posts' do
    @posts = @posts.order('created_at DESC')
    @section = 'Newest'
    erb :'posts/index.html'
  end

  get '/posts/newest' do
    redirect '/posts'
  end
  get '/posts/top' do
    @posts = @posts.order('comments.size DESC')
    @section = 'Top'
    erb :'posts/index.html'
  end

  get '/posts/new' do
    erb :'posts/new.html'
  end

  post '/posts' do
    params.inspect
    @post = Post.new(description: params[:desc])
    @post.author = params[:author]
    @post.title = params[:title]

    if @post.save
      redirect '/posts'
    else
      #  flash[:error] = 'Your post could not be created. Choose your content wisely'
      redirect '/posts/new'

    end
  end

  get '/posts/:id' do
    @post = Post.find(params[:id])
    erb :'posts/show.html'
  end

  get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    erb :'posts/edit.html'
  end

  patch '/posts/:id' do
    @post = Post.find(params[:id])
    @post.description = params[:description]
    @post.title = params[:title]
    if @post.save
      redirect "/posts/#{params[:id]}"
    else
      #   flash[:error] = 'Your post could not be edited. Choose your content wisely'
      redirect "/posts/#{params[:id]}/edit"
    end
  end

  delete '/posts/:id' do
    @post = Post.find(params[:id])
    @post.delete
    redirect '/posts'
  end
end
