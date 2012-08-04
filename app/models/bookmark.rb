class Bookmark < ActiveRecord::Base

    validates_presence_of :url
    validates_presence_of :tags

    belongs_to :site

    # Site depends on the url, so does not bother it from outside
    private :site=

    def url=(url)
        self[:url] = url

        self.site = Site.find_by_domain(domain)
        unless site
            self.site = Site.new
            self.site.domain = domain
        end
    end

    def tags
        return [] unless self[:tags]
        self[:tags].split(" ")
    end

private

    def domain
        return "" if self[:url] == nil or self[:url] == ""
        url.match(/^(http:\/\/){0,1}([^\/]+)(.*)$/)[2]
    end

end
