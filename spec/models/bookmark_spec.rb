require 'spec_helper'
require 'remote_connection_mocks'

describe Bookmark do

    before :each do
        @bookmark = create_bookmark
    end

    it "should be able to store URL" do
        @bookmark.url = "http://this.is.an.url"
        @bookmark.save!

        bookmark = Bookmark.find_all_by_url("http://this.is.an.url")
        bookmark.length.should == 1
    end

    it "should be able to store tags" do
        @bookmark.tags = "tag1 tag2"
        @bookmark.save!

        bookmark = Bookmark.find_all_by_tags("tag1 tag2")
        bookmark.length.should == 1
    end

    it "should represent the tags in array form" do
        @bookmark.tags = "tag1 tag2"
        @bookmark.tags.class.should == Array
        @bookmark.tags[0].should == "tag1"
        @bookmark.tags[1].should == "tag2"
    end

    it "should not be valid if URL is missing" do
        @bookmark.url = nil
        @bookmark.should_not be_valid
    end

    it "should not be valid if TAGS is missing" do
        @bookmark.tags = nil
        @bookmark.should_not be_valid
    end

    it "should be modeled as belonging to a site" do
        @bookmark.site.class.should == Site
    end

    it "URL needs to be parsed to extract the domain" do
        @bookmark.url = "http://my.url/example"
        @bookmark.site.domain.should == "my.url"

        @bookmark.url = "cnn.com/example"
        @bookmark.site.domain.should == "cnn.com"

        @bookmark.url = "localhost/example"
        @bookmark.site.domain.should == "localhost"
    end

    it "the site attribute is not changable from outside" do
        lambda { @bookmark.site = Site.new }.should raise_error
    end

    it "must create site domain on save if it doesn't exist in the database before" do
        @bookmark.url = "localhost/path"
        Site.find_by_domain("localhost").should == nil
        @bookmark.save!
        Site.find_by_domain("localhost").should_not == nil
    end

    it "should not create new domain when one instance is exists" do
        @bookmark.url = "domain/path"
        @bookmark.save!

        original_site_id = Site.find_by_domain("domain").id

        other_bookmark = create_bookmark
        other_bookmark.url = "domain/another_path"
        other_bookmark.save!

        other_bookmark.site_id.should == original_site_id
    end

    it "should attached to the corresponding site when created" do
        site = Site.new
        site.domain = "domain.tld"
        site.save!

        bookmark = create_bookmark
        bookmark.url = "http://domain.tld/appletree"
        bookmark.save!

        site.bookmarks.length.should == 1
        site.bookmarks.first.url == "http://domain.tld/appletree"
    end

    it "should use the http prefix for urls" do
        @bookmark.url = "bbc.co.uk"
        @bookmark.url.should == "http://bbc.co.uk"
    end

    it "should shorten the url with tinyurl" do
        @shortener.body = "tinyurl.com/6xcwayn"

        @bookmark.url = "alphasights.com"
        @bookmark.short.should == "http://tinyurl.com/6xcwayn"
        @bookmark.save!

        Bookmark.find(@bookmark.id).short.should == "http://tinyurl.com/6xcwayn"
    end

    it "should not have public short= method" do
        lambda { @bookmark.short = "Site.new" }.should raise_error
    end

    it "should store the page title" do
        @collector.title = "Apple"

        @bookmark.url = "http://www.apple.com/"
        @bookmark.title.should == "Apple"
        @bookmark.save!

        Bookmark.find_by_title("Apple").should_not == nil
    end

    it "should store other meta information" do
        @collector.description = "Apple description"

        @bookmark.url = "http://www.apple.com/"
        @bookmark.description.should == "Apple description"
        @bookmark.save!

        Bookmark.find(@bookmark.id).description.should == "Apple description"
    end


    describe "search" do

        it "should have search interface" do
            Bookmark.should respond_to(:search)
        end

        it "should return array" do
            Bookmark.search("").class.should == ActiveRecord::Relation
        end

        it "should be able to search for any field of the bookmarks" do
            @collector.title = "Title"
            @collector.description = "description"
            @shortener.body = "tinyurl.com/shorten"

            @bookmark.url = "http://www.alphasights.com/"
            @bookmark.tags = "tag1 tag2"
            @bookmark.save!

            Bookmark.search("sights.com").length.should == 1

            Bookmark.search("tree").length.should == 0
            Bookmark.search("Ttitle").length.should == 0
            Bookmark.search("title").length.should == 1
            Bookmark.search("Title").length.should == 1

            Bookmark.search("shorten").length.should == 1

            Bookmark.search("description").length.should == 1

            Bookmark.search("tag1").length.should == 1
            Bookmark.search("tag2").length.should == 1
            Bookmark.search("tag3").length.should == 0
        end

    end

protected

    def create_bookmark
        bookmark = Bookmark.new

        @collector = BookingToolMocks::MetaInfo.new
        bookmark.meta_collector = @collector

        @shortener = BookingToolMocks::TinyURL.new
        bookmark.url_shortener = @shortener

        bookmark.url = "http://sample.url"
        bookmark.tags = "mytag"
        bookmark
    end

end

module MetaInspector
    class Scraper
        def add_fatal_error(error)
        end
    end
end