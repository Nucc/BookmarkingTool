require 'spec_helper'

describe BookmarksController do

    describe "GET /new" do

        it "should response 200 to new action" do
            get :new
            response.status.should == 200
        end

    end

    describe "GET /show" do

        it "should response 200 to show action" do

            bookmark = Bookmark.new
            bookmark.id = 1
            bookmark.url = "alphasights.com"
            bookmark.tags = "tag1"

            Bookmark.should_receive(:find).with("1").and_return(bookmark)

            get :show, :id => 1

            response.status.should == 200
        end

    end
end