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

end