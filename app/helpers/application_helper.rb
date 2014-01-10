module ApplicationHelper
  def fix_url(url)
    url.downcase =~ /^https?:\/\// ? url : 'http://' + url
  end

end
