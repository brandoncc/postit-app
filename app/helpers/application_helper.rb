module ApplicationHelper
  def fix_url(url)
    url.downcase =~ /^https?:\/\// ? url : 'http://' + url
  end

  def nice_time(time)
    pretty_time = pretty_timeframes(time)

    if pretty_time == ''
      "#{time.strftime('%a, %b %e, %Y at %l:%M %P')}"
    else
      "#{pretty_time} (#{time.strftime('%a, %b %e, %Y at %l:%M %P')})"
    end
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
    elsif seconds_passed >= 60*60*24 and seconds_passed < 60*60*24*365
      time_string = "about #{pluralize(seconds_passed / (60*60*24), 'month')} ago"
    else
      time_string = ''
    end

    time_string.
        gsub(/^about 1 second/, 'a second').
        gsub(/^1 minute/, 'a minute').
        gsub(/^1 hour/, 'an hour').
        gsub(/^1 day/, 'yesterday').
        gsub(/^1 month/, 'a month')
  end
end
