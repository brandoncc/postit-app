module ApplicationHelper
  def fix_url(url)
    url.downcase =~ /^https?:\/\// ? url : 'http://' + url
  end

  def nice_time(time)
    time = time.in_time_zone(current_user.time_zone) if logged_in? && !current_user.time_zone.nil?
    pretty_time = pretty_timeframes(time)

    if pretty_time == ''
      "on #{time.strftime('%a, %b %e, %Y at %l:%M %P')}"
    else
      "#{pretty_time}"
    end
  end

  def pretty_votes(object)
    pluralize(object.votes_count, 'vote') if !!object
  end

  private
  def pretty_timeframes(time)
    seconds_passed = (Time.now - time).ceil

    if seconds_passed < 60
      time_string = "about #{pluralize(seconds_passed, 'second')} ago"
    elsif seconds_passed >= 60 and seconds_passed < 60*60
      time_string = "about #{pluralize((seconds_passed / (60)), 'minute')} ago"
    elsif seconds_passed >= 60*60 and seconds_passed < 60*60*24
      time_string = "about #{pluralize(seconds_passed / (60*60), 'hour')} ago"
    elsif seconds_passed >= 60*60*24 and seconds_passed <= 60*60*24*31
      time_string = "about #{pluralize(seconds_passed / (60*60*24), 'day')} ago"
    else
      time_string = ''
    end

    time_string.
        gsub(/^about 1 second/, 'a second').
        gsub(/^about 1 minute/, 'about a minute').
        gsub(/^about 1 hour/, 'about an hour').
        gsub(/^about 1 day ago/, 'yesterday')
  end
end
