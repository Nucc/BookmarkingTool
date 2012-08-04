class Site < ActiveRecord::Base

    validates_uniqueness_of :domain, :on => :create, :message => "must be unique"

    has_many :bookmarks

end
