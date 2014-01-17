xml.instruct!
xml.post do
  xml.title @post.title
  xml.url @post.url
  xml.description @post.description
  xml.votes post.votes.sum(:value)
  xml.creator @post.creator.username
  xml.posted_at @post.created_at
  xml.comments do
    @post.comments.each do |comment|
      xml.comment do
        xml.body comment.body
        xml.creator comment.creator.username
        xml.commented_at comment.created_at
      end
    end
  end
end
