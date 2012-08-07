require 'spec_helper'

describe "sites/show" do

    before :each do
        @collector = BookmarkingMocks::MetaInfo.new
        @collector.title = "Title"
        @collector.description = "Description"

        @shortener = BookmarkingMocks::TinyURL.new
        @shortener.body = "http://tinyurl.com/alpha"
    end

    it "is able to list bookmarks of a site" do
        site = stub_model(Site, :id => 1, :domain => "alphasights.com")


        @collector.title = "CAREERS"
        bookmarks = []
        bookmarks << stub_model(Bookmark, :id => 1, :meta_collector => @collector, :url_shortener => @shortener,
                                 :site_id => 1, :url => "alphasights.com/careers")

        @collector.title = "WHATWEDO"
        bookmarks << stub_model(Bookmark, :id => 2, :meta_collector => @collector, :url_shortener => @shortener,
                                 :site_id => 1, :url => "alphasights.com/what-we-do")

        site.stub!(:bookmarks).and_return(bookmarks)
        assign :site, site

        render

        rendered.should have_xpath("//div[@id='site']//*[text()='alphasights.com']")
        rendered.should have_xpath("//div[@id='site']//li//a[@href='/bookmarks/1' and text()='CAREERS']")
        rendered.should have_xpath("//div[@id='site']//li//a[@href='/bookmarks/2' and text()='WHATWEDO']")
    end

    it "displays No site has been found when site is missing" do
        render
        rendered.should have_content("No site has been found...")
    end


end