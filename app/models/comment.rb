class Comment < ActiveRecord::Base
  include Voteable

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :post

  validates_presence_of :body
end
