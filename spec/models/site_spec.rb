require 'spec_helper'

describe Site do

    it "should have name field" do
        site = Site.new
        site.should respond_to :name
    end

end
