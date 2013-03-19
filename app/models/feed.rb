class Feed < ActiveRecord::Base
  attr_accessible :etag, :feed_url, :title, :url, :category_id

  belongs_to :category
  has_many :entries, dependent: :delete_all
  validates_uniqueness_of :url

  def get_entries
    feed = Feedzirra::Feed.fetch_and_parse(self.feed_url)
    feed.entries.each do |e|
      entry = Entry.new
      entry.feed_id = self.id
      entry.title = e.title
      entry.url = e.url
      entry.author = e.author
      entry.summary = e.summary
      entry.content = e.content
      entry.published = e.published
      entry.categories = e.categories
      entry.save
    end
  end

  def update_entries
    lastentry = self.entries.last
    if lastentry.nil?
      get_entries
    else
      feed = Feedzirra::Feed.fetch_and_parse(self.feed_url)
      if feed.last_modified != self.last_modified
        feed.entries.each do |e|
          if e.published > lastentry.published
            entry = Entry.new
            entry.feed_id = self.id
            entry.title = e.title
            entry.url = e.url
            entry.author = e.author
            entry.summary = e.summary
            entry.content = e.content
            entry.published = e.published
            entry.categories = e.categories
            entry.save
          end
        end
      end
    end
  end
end
