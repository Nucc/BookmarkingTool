require "meta_info.rb"
require "tinyurl.rb"

class Bookmark < ActiveRecord::Base

    validates_presence_of :url
    validates_presence_of :tags

    belongs_to :site

    SEARCHABLE_FIELDS = [:url, :tags, :title, :description, :short]

    # Site depends on the url, so does not bother it from outside
    private :site=

    def self.search(value)
        table = Bookmark.arel_table
        searchable_fields = SEARCHABLE_FIELDS.dup

        filter = table[searchable_fields.shift].matches("%#{value}%")
        searchable_fields.each do |field|
            filter = filter.or(table[field].matches("%#{value}%"))
        end
        Bookmark.where(filter)
    end

    def url=(url)
        self[:url] = append_protocol(url)
        self.site = Site.find_or_create_by_url(url)
        set_meta_information
    end

    def tags
        return [] unless self[:tags]
        self[:tags].split(" ")
    end

    def meta_collector=(collector)
        @meta_collector = collector
    end

    def url_shortener=(shortener)
        @url_shortener = shortener
    end

    def short
        "http://tinyurl.com/#{self[:short]}"
    end

private

    def meta_collector
        @meta_collector or Bookmarking::MetaInfo.new
    end

    def url_shortener
        @url_shortener or Bookmarking::TinyURL.new
    end

    def short=(url)
        self[:short] = url.split("tinyurl.com/")[1]
    end

    def set_meta_information
        set_title_and_description
        set_short_url
    end

    def append_protocol(url)
        if url and url.length > 0
            return "http://#{url}" unless url =~ /^(http|https):\/\//
        end
        url
    end

    def set_title_and_description
        meta_info = meta_collector.info(url)
        self.title = meta_info.title
        self.description = meta_info.description
        logger.debug "Bookmark: Metainformation has been fetched; title='%s', description='%s'" % [self.title, self.description]
    rescue => e
        logger.error "Bookmark: Could not fetch meta information; reason='%s'" % e.inspect
    end

    def set_short_url
        self.short = url_shortener.use(url).body
        logger.debug "Bookmark: Short url has been fetched; short_url='%s'" % [self.short]
    rescue => e
        logger.error "Bookmark: Could not fetch tiny url; reason='%s'" % e.inspect
    end

end
