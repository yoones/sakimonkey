class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :load_globals

  def load_globals
    @sidebar_categories = Category.find(:all, include: :feeds)
    @sidebar_feeds = Feed.where(category_id: nil)
    nbr_unread = 0
    Feed.all.each do |f|
      nbr_unread += f.unread
    end
    @stats = {
      nbr_feeds: Feed.count,
      nbr_unread: nbr_unread,
      nbr_entries: Entry.count,
      last_update: Feed.first.updated_at.strftime("%Hh%M")
    }
  end
end
