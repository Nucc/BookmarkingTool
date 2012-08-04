require 'spec_helper'

describe SitesController do

    describe "GET /" do

        it "should response 200 to index action" do
            get :index
            response.status.should == 200
        end

    end

end