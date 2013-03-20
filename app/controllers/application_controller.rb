class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :load_globals

  def load_globals
    @_feeds = Feed.all
    @_categories = Category.all
    @stats = {
      nbr_feeds: Feed.count,
      nbr_entries: Entry.count,
      last_update: Feed.first.updated_at.strftime("%Hh%M")
    }
  end
end
