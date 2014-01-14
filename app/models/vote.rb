class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'

  validates_uniqueness_of :user_id, scope: [:voteable_id, :voteable_type]
end
