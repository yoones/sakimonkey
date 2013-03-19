class Entry < ActiveRecord::Base
  attr_accessible :author, :categories, :content, :feed_id, :published, :summary, :title, :url

  belongs_to :feed

  validates_uniqueness_of :url, scope: :feed_id
end
