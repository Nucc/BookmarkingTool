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

end
