require 'spec_helper'

describe SitesController do

    describe "GET /" do

        it "should response 200 to index action" do
            get :index
            response.status.should == 200
        end

    end

    describe "GET /show" do
        it "should response 200 to show action" do
            site = Site.new
            site.domain = "alphasights.com"

            Site.should_receive(:find).with("1").and_return(site)

            get :show, :id => 1

            response.status.should == 200
        end
    end

end