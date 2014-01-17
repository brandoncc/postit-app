xml.instruct!
xml.category do
  xml.name @category.name
  xml.posts do
    @category.posts.each do |post|
      xml.post do
        xml.title post.title
        xml.url post.url
        xml.description post.description
        xml.votes post.votes.sum(:value)
        xml.posted_at post.created_at
      end
    end
  end
end
