require 'spec_helper'

describe "sites/show" do

    it "is able to list bookmarks of a site" do
        site = stub_model(Site, :id => 1, :domain => "alphasights.com")

        bookmarks = [
            stub_model(Bookmark, :id => 1, :site_id => 1, :url => "alphasights.com/careers"),
            stub_model(Bookmark, :id => 2, :site_id => 1, :url => "alphasights.com/what-we-do")
        ]

        site.stub!(:bookmarks).and_return(bookmarks)
        assign :site, site

        render

        rendered.should have_xpath("//div[@id='site']//*[text()='alphasights.com']")
        rendered.should have_xpath("//div[@id='site']//li//a[@href='/bookmarks/1' and text()='http://alphasights.com/careers']")
        rendered.should have_xpath("//div[@id='site']//li//a[@href='/bookmarks/2' and text()='http://alphasights.com/what-we-do']")
    end

    it "displays No site has been found when site is missing" do
        render
        rendered.should have_content("No site has been found...")
    end


end