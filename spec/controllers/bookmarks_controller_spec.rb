require 'spec_helper'

describe BookmarksController do

    describe "GET /new" do

        it "should response 200 to new action" do
            get :new
            response.status.should == 200
        end

    end

end