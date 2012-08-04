class AddingShortFieldToBookmark < ActiveRecord::Migration
  def change
    add_column :bookmarks, :short, :string
  end
end
