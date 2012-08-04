require 'spec_helper'

describe Bookmark do

    before :each do
        @bookmark = Bookmark.new
        @bookmark.url = "http://sample.url"
        @bookmark.tags = "mytag"
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
        @bookmark.site.name.should == "my.url"

        @bookmark.url = "no_http.com/example"
        @bookmark.site.name.should == "no_http.com"

        @bookmark.url = "no_top_level/example"
        @bookmark.site.name.should == "no_top_level"
    end

end