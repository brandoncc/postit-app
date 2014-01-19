class Category < ActiveRecord::Base
  include SluggableBrandon

  has_many :post_categories
  has_many :posts, through: :post_categories

  validates_presence_of :name
end
