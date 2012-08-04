class Bookmark < ActiveRecord::Base

    validates_presence_of :url
    validates_presence_of :tags

    belongs_to :site

    def url=(url)
        self[:url] = url
        self.site = Site.new
        self.site.name = domain
    end

private

    def domain
        return "" if self[:url] == nil or self[:url] == ""
        url.match(/^(http:\/\/){0,1}([^\/]+)(.*)$/)[2]
    end

end
