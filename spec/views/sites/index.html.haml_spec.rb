require 'spec_helper'

describe "sites/index" do

    it "is able to list sites" do
        assign(:sites, [
            stub_model(Site, :id => 1, :domain => "bbc.co.uk"),
            stub_model(Site, :id => 2, :domain => "alphasights.com"),
        ])

        render

        rendered.should have_xpath("//div[@id='sites']//li//a[@href='/sites/1']//*[text()='bbc.co.uk']")
        rendered.should have_xpath("//div[@id='sites']//li//a[@href='/sites/2']//*[text()='alphasights.com']")
    end

end