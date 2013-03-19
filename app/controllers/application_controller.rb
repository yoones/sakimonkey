class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :load_globals

  def load_globals
    @_feeds = Feed.all
    @_categories = Category.all
  end
end
