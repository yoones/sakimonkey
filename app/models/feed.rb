class Feed < ActiveRecord::Base
  attr_accessible :etag, :feed_url, :title, :url, :category_id

  belongs_to :category
  has_many :entries, dependent: :delete_all
  validates_uniqueness_of :feed_url

  def get_entries
    feed = Feedzirra::Feed.fetch_and_parse(self.feed_url)
    feed.entries.each do |e|
      entry = Entry.new
      entry.feed_id = self.id
      entry.title = e.title
      entry.url = e.url
      entry.author = e.author
      entry.summary = e.summary
      entry.published = e.published
      unless e.is_a?(Feedzirra::Parser::ITunesRSSItem)
        entry.content = e.content
        entry.categories = e.categories
      end
      entry.unread = true
      entry.save
    end
    self.unread = feed.entries.count
    self.save
  end

  def update_entries
    feed = Feedzirra::Feed.fetch_and_parse(self.feed_url, { if_modified_since: self.last_modified })
    if feed.is_a?(Integer) == false and feed.last_modified < self.last_modified
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
        entry.unread = true
        if entry.save!
          self.unread += 1
        end
      end
      self.save
    end
  end
end
