class Site < ActiveRecord::Base

    validates_uniqueness_of :domain, :on => :create, :message => "must be unique"

    has_many :bookmarks

    def self.find_or_create_by_url(url)
        domain = extract_domain(url)
        site = Site.find_by_domain(domain)
        if site.nil?
            site = Site.new
            site.domain = domain
        end
        site
    end

private

    def self.extract_domain(url)
        return "" if url == "" or url.nil?
        url.match(/^((http|https):\/\/){0,1}([^\/]+)(.*)$/)[3]
    end

end
