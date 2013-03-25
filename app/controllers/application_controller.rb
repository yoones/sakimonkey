class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :load_globals

  def load_globals
    @sidebar_categories = Category.find(:all, include: :feeds)
    @sidebar_feeds = Feed.where(category_id: nil)
    @stats = {
      nbr_feeds: Feed.count,
      nbr_entries: Entry.count,
      last_update: Feed.first.updated_at.strftime("%Hh%M")
    }
  end
end
