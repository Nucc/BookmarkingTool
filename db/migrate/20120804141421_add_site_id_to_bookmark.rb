class AddSiteIdToBookmark < ActiveRecord::Migration
  def change
    change_table :bookmarks do |t|
        t.references :site
    end
  end
end
