require 'spec_helper'

describe Site do

    it "should have name field" do
        site = Site.new
        site.should respond_to :name
    end

    it "domain names should be unique" do
        site = Site.new
        site.name = "name"
        site.save!

        site = Site.new
        site.name = "name"
        lambda { site.save! }.should raise_error(ActiveRecord::RecordInvalid)
    end

end
