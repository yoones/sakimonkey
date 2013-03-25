class AddUnreadToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :unread, :integer, default: 0
  end
end
