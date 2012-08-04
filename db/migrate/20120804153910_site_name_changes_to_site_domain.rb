class SiteNameChangesToSiteDomain < ActiveRecord::Migration
    def change
      rename_column :sites, :name, :domain
    end
end
