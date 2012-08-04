require 'spec_helper'

describe Bookmark do

    it "should be able to store URL" do
        bookmark = Bookmark.new
        bookmark.url = "http://this.is.an.url"
        bookmark.save!

        bookmark = nil
        bookmark = Bookmark.find_all_by_url("http://this.is.an.url")
        bookmark.length.should == 1
    end

    it "should be able to store tags" do
        bookmark = Bookmark.new
        bookmark.tags = "tag1 tag2"
        bookmark.save!

        bookmark = nil
        bookmark = Bookmark.find_all_by_tags("tag1 tag2")
        bookmark.length.should == 1
    end

end