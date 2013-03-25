class AddUnreadToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :unread, :boolean, default: true
  end
end
