class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  validates :title, :author, :description, presence: true

  def newest
    Post.order('created_at DESC')
  end

  def top
    Post.order('comments.size DESC')
  end
end
