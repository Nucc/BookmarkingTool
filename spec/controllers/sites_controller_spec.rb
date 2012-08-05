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

    it "should not allow destroy, new, create and update actions" do
        lambda {delete :destroy}.should raise_exception
        lambda {get :new}.should raise_exception
        lambda {post :create}.should raise_exception
        lambda {put :update}.should raise_exception
    end

end