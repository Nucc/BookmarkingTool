require 'spec_helper'
require 'remote_connection_mocks'

describe "bookmarks/search" do

    it "displays no result message when no search result" do
        assign(:bookmarks, [])
        render
        rendered.should have_content("No search result...")
    end

    it "displays no result message when collection is missing" do
        render
        rendered.should have_content("No search result...")
    end
end