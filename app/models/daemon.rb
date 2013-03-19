class Daemon
  def self.update_all_feeds
    Feed.all.each do |feed|
      feed.update_entries
      feed.touch
      feed.save
    end
  end
end
