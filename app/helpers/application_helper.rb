module ApplicationHelper
  def fix_url url
    url.starts_with?('http://') ? url : "http://#{url}"
  end

  def format_time time
    time.to_formatted_s :long
  end
end
