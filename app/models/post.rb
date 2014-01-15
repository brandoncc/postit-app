class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  after_create :generate_slug

  validates_presence_of :title, :url, :description

  def votes_count
    votes.sum(:value)
  end

  def generate_slug
    potential_slug = self.title.downcase.gsub(/\s+/, '-').gsub(/[^A-Za-z0-9-]/, '')

    index = 1

    until Post.find_by(slug: potential_slug).nil?

      if index == 1
        potential_slug += "-#{index}"
      else
        potential_slug.gsub!(/-\d+$/, "-#{index}")
      end

      index += 1
    end

    self.slug = potential_slug
    self.save
  end

  def to_param
    self.slug
  end
end
