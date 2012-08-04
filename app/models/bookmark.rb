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
        set_meta_information
    end

    def url
        return "" unless self[:url]

        if self[:url] and self[:url].length > 0
            return "http://#{self[:url]}" unless self[:url] =~ /^http:\/\//
        end

        self[:url]
    end

    def tags
        return [] unless self[:tags]
        self[:tags].split(" ")
    end

private

    def short=(url)
        self[:short] = url.split("tinyurl.com/")[1]
    end

    def domain
        return "" if url == ""
        url.match(/^(http:\/\/){0,1}([^\/]+)(.*)$/)[2]
    end

    def set_meta_information
        set_title_and_description
        set_short_url
    end

    def set_title_and_description
        begin
            meta_info = MetaInspector.new(url)
            self.title = meta_info.title
            self.description = meta_info.description
        rescue
            # LOGGING
        end
    end

    def set_short_url
        begin
            tinyurl = URI.parse("http://tinyurl.com/")
            self.short = Net::HTTP.start(tinyurl.host, tinyurl.port) { |http|
                http.get("/api-create.php?url=" + url)
            }.body
        rescue
            #LOGGING
        end
    end

end
