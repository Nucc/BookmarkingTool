class BookmarkDescriptionShouldBeTextField < ActiveRecord::Migration
  def change
    change_column :bookmarks, :description, :text
  end
end
