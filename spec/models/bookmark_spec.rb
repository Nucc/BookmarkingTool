require 'spec_helper'

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

        @bookmark.url = "no_http.com/example"
        @bookmark.site.domain.should == "no_http.com"

        @bookmark.url = "no_top_level/example"
        @bookmark.site.domain.should == "no_top_level"
    end

    it "the site attribute is not changable from outside" do
        lambda { @bookmark.site = Site.new }.should raise_error
    end

    it "must create site domain on save if it doesn't exist in the database before" do
        @bookmark.url = "my_domain/path"
        Site.find_by_domain("my_domain").should == nil
        @bookmark.save!
        Site.find_by_domain("my_domain").should_not == nil
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

protected

    def create_bookmark
        bookmark = Bookmark.new
        bookmark.url = "http://sample.url"
        bookmark.tags = "mytag"
        bookmark
    end

end