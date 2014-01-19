module Voteable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :voteable
  end

  def votes_count
    self.votes.sum(:value)
  end
end

