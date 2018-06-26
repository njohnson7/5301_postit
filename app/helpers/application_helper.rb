module ApplicationHelper
  def fix_url url
    url.starts_with?('http://') ? url : "http://#{url}"
  end

  def format_time time
    time.strftime "%m/%d/%Y %l:%M%P %Z"
  end

  def user_page?
    params[:controller] == 'users'
  end

  def sort_by_vote(voteables)
    voteables.sort_by { |voteable| -voteable.total_votes }
  end
end
