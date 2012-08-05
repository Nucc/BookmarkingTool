class BookmarksController < ApplicationController

    def new
        @bookmark = Bookmark.new
    end

    def create

        begin
            @bookmark = Bookmark.new
            @bookmark.url = params["bookmark"]["url"]
            @bookmark.tags = params["bookmark"]["tags"]
            @bookmark.save!

            @bookmark = Bookmark.new
            flash.now[:notice] = "Bookmark has been saved!"
        rescue
            flash.now[:error] = "Bookmark has missing attributes!"
        end
        render :action => :new
    end

    def show
        @bookmark = Bookmark.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        # LOGGING
    end

    def search
    end

end
