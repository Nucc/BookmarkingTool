class Bookmark < ActiveRecord::Base

    validates_presence_of :url
    validates_presence_of :tags

end
