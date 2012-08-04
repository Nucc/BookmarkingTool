require 'spec_helper'

describe "Bookmarks" do

    describe "GET /new" do

        it "should render the new action" do
            get "bookmarks/new"
            response.should render_template(:new)
        end

        it "should contain url and tags fields" do
            visit "/bookmarks/new"

            page.should have_selector("form//input[@id=bookmark_url]")
            page.should have_selector("form//input[@id=bookmark_tags]")

        end

        it "should save the bookmark when that is valid" do
            visit "/bookmarks/new"

            fill_in "bookmark_url", :with => "http://wikipedia.org"
            fill_in "bookmark_tags", :with => "wiki lexicon"
            click_button "Save bookmark"

            page.should have_content("Bookmark has been saved!")
        end

        it "should not save the bookmark when that is invalid" do
            visit "/bookmarks/new"

            fill_in "bookmark_tags", :with => "wiki lexicon"
            click_button "Save bookmark"

            page.should have_content("Bookmark has missing attributes!")
        end


    end
end