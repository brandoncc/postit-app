class Category < ActiveRecord::Base
  include SluggableBrandon

  has_many :post_categories
  has_many :posts, through: :post_categories

  validates_presence_of :name

  sluggable_column :name
  before_save :generate_slug!
end
