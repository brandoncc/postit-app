class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, length: { minimum: 5 }, on: :create

  before_save :generate_slug

  def generate_slug
    potential_slug = self.username.downcase.gsub(/\s+/, '-').gsub(/[^A-Za-z0-9-]/, '')

    index = 1

    until potential_slug == self.slug || User.find_by(slug: potential_slug).nil?

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
