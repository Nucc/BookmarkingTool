class Bookmark < ActiveRecord::Base

    validates_presence_of :url
    validates_presence_of :tags

    belongs_to :site

    def url=(url)
        self.site = Site.new
        self[:url] = url
    end

    def site
        Site.new
    end

end
