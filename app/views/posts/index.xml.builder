xml.instruct!
xml.posts do
  @posts.each do |post|
    xml.post do
      xml.title post.title
      xml.url post.url
      xml.description post.description
      xml.votes post.votes.sum(:value)
      xml.creator post.creator.username
      xml.posted_at post.created_at
    end
  end
end
