require 'spec_helper'
require 'remote_connection_mocks'

describe "bookmarks/show" do

    before :each do
        @collector = BookmarkingMocks::MetaInfo.new
        @collector.title = "Title"
        @collector.description = "Description"

        @shortener = BookmarkingMocks::TinyURL.new
        @shortener.body = "http://tinyurl.com/alpha"
    end

    it "displaying a bookmark should display its URL, title, tags, shortening" do

        @collector.title = "AlphaSights"
        assign(:bookmark, stub_model(Bookmark, :meta_collector => @collector, :url_shortener => @shortener,
                                               :id => 1, :site_id => 1, :url => "www.alphasights.com/careers", :tags => "tag"))

        render

        url_should_be("http://www.alphasights.com/careers")
        title_should_be("AlphaSights")
        tags_should_be("tag")
        shorten_should_be("http://tinyurl.com/alpha")
    end

    it "should show No title when title is missing" do
        @collector.title = "No title"
        assign(:bookmark, stub_model(Bookmark, :meta_collector => @collector, :url_shortener => @shortener,
                                               :id => 1, :site_id => 1, :url => "http://localhost", :tags => "tag"))

        render

        title_should_be("No title")
    end

    it "should show No description the description is missing" do
        @collector.description = "No description"
        assign(:bookmark, stub_model(Bookmark, :meta_collector => @collector, :url_shortener => @shortener,
                                               :id => 1, :site_id => 1, :url => "http://localhost", :tags => "tag"))

        render

        description_should_be("No description")
    end

    it "should show Bookmark is not found when bookmark is not found" do
        render

        @rendered.should have_content("Bookmark is not found!")
    end

private

    %w(url tags title shorten description).each do |method|
        define_method("#{method}_should_be") do |expected|
            rendered.should have_xpath("//div[@id='bookmark']//*[@class='#{method}']//*[text()='#{expected}']")
        end
    end
end