module ApplicationHelper
  def fix_url(url)
    url.starts_with?('http://') ? url : "http://#{url}"
  end
end
