class Comment < ActiveRecord::Base
  belongs_to :parent, class_name: 'Comment', foreign_key: :comment_id
  has_many :replies, class_name: 'Comment', dependent: :destroy
  validates :author, :description, presence: true
end
