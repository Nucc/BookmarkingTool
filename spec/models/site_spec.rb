require 'spec_helper'

describe Site do

    it "should have domain field" do
        site = Site.new
        site.should respond_to :domain
    end

    it "domain names should be unique" do
        site = Site.new
        site.domain = "name"
        site.save!

        site = Site.new
        site.domain = "name"
        lambda { site.save! }.should raise_error(ActiveRecord::RecordInvalid)
    end

    it "should be able to find an existing or create a new site" do
        site = Site.find_or_create_by_url("http://localhost/path")
        site.save!

        other_site = Site.find_or_create_by_url("http://localhost/path")
        site.id.should == other_site.id
    end

end
