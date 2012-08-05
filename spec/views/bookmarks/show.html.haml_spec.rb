require 'spec_helper'

describe "bookmarks/show" do

    it "displaying a bookmark should display its URL, title, tags, shortening" do

        assign(:bookmark, stub_model(Bookmark, :id => 1, :site_id => 1, :url => "www.alphasights.com/careers", :tags => "tag"))

        render

        url_should_be("http://www.alphasights.com/careers")
        title_should_be("AlphaSights")
        tags_should_be("tag")
        shorten_should_be("tinyurl.com/7dc64ez")
    end

    it "should show No title when title is missing" do
        assign(:bookmark, stub_model(Bookmark, :id => 1, :site_id => 1, :url => "http://localhost", :tags => "tag"))

        render

        title_should_be("No title")
    end

    it "should show No description the description is missing" do
        assign(:bookmark, stub_model(Bookmark, :id => 1, :site_id => 1, :url => "http://localhost", :tags => "tag"))

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