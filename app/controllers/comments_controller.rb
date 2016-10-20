
class CommentsController < ApplicationController
  get '/posts/:post_id/comments/new/:id' do
    @post = Post.find(params[:post_id])
    @parent = Comment.find(params[:id])
    @comment_id = @parent.id
    erb :'comments/new.html'
  end

  get '/posts/:post_id/comments/new' do
    @post = Post.find(params[:post_id])
    erb :'comments/new.html'
  end

  post '/posts/:post_id/comments' do
    if params[:comment_id] != ''

      @parent = Comment.find(params[:comment_id])
      @comment = Comment.new(description: params[:desc], author: params[:author])
      @comment.comment_id = @parent.id
      @comment.post_id = params[:post_id]
      if @comment.save
        redirect "/posts/#{params[:post_id]}"
      else
        @comment.errors.push = 'Your comment could not be created. Choose your content wisely'
        redirect "/posts/#{params[:post_id]}/comments"
      end
    else
      @parent = Post.find(params[:post_id])
      @comment = Comment.new(description: params[:desc], author: params[:author])
      @comment.post_id = @parent.id
      if @comment.save
        redirect "/posts/#{params[:post_id]}"
      else
        #  flash[:error] = 'Your comment could not be created. Choose your content wisely'
        redirect "/posts/#{params[:post_id]}/comments"
      end
    end
  end

  get '/posts/:post_id/comments/:id/edit' do
    @comment_to_edit = Comment.find(params[:id])
    @post = Post.find(params[:post_id])
    erb :'comments/edit.html'
  end

  patch '/posts/:post_id/comments/:id' do
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.description = params[:desc]
    if @comment.save
      redirect "/posts/#{params[:post_id]}"
    else
      #  flash[:error] = 'Your comment could not be created. Choose your content wisely'
      redirect "/posts/#{params[:post_id]}/comments/#{params[:id]}"
    end
  end

  delete '/posts/:post_id/comments/:id' do
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.replies.destroy_all
    @comment.delete
    redirect "/posts/#{params[:post_id]}"
  end
end
