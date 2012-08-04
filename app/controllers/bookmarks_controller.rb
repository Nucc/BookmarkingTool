class BookmarksController < ApplicationController

    def new
        @bookmark = Bookmark.new
    end

    def create

        bookmark = Bookmark.new
        bookmark.url = params["bookmark"]["url"]
        bookmark.tags = params["bookmark"]["tags"]
        bookmark.save!

        render :text => "Bookmark has been saved!"
    rescue
        render :text => "Bookmark has missing attributes!"
    end

end
