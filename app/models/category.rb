class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories

  validates_presence_of :name

  before_save :generate_slug

  def generate_slug
    potential_slug = self.name.downcase.gsub(/\s+/, '-').gsub(/[^A-Za-z0-9-]/, '')

    index = 1

    until Category.find_by(slug: potential_slug).nil?
      if index == 1
        potential_slug += "-#{index}"
      else
        potential_slug.gsub!(/-\d+$/, "-#{index}")
      end

      index += 1
    end

    self.slug = potential_slug
  end

  def to_param
    self.slug
  end
end
