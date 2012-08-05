require 'spec_helper'

describe BookmarksHelper do

    it "should convert title to No title when title is empty" do

        mock = Bookmark.new
        mock.should_receive(:title).any_number_of_times.and_return("")

        title_of(mock).should == "No title"
    end

    it "should convert title to No title when title is nil" do

        mock = Bookmark.new
        mock.should_receive(:title).any_number_of_times.and_return(nil)

        title_of(mock).should == "No title"
    end

    it "should not convert title when title is not empty" do

        mock = Bookmark.new
        mock.should_receive(:title).any_number_of_times.and_return("Title")

        title_of(mock).should == "Title"
    end

    it "should convert the description to No description when it is nil" do
        mock = Bookmark.new
        mock.should_receive(:description).any_number_of_times.and_return(nil)
        description_of(mock).should == "No description"
    end

    it "should not convert the description when description is string" do
        mock = Bookmark.new
        mock.should_receive(:description).any_number_of_times.and_return("")
        description_of(mock).should == ""
    end


    it "should not convert the description contains letters" do
        mock = Bookmark.new
        mock.should_receive(:description).any_number_of_times.and_return("Description")
        description_of(mock).should == "Description"
    end

end
