class BookmarksController < ApplicationController

    def new
        @bookmark = Bookmark.new
    end

    def create
        @bookmark = Bookmark.new
        @bookmark.url = params["bookmark"]["url"]
        @bookmark.tags = params["bookmark"]["tags"]

        if @bookmark.save
            @bookmark = Bookmark.new
            logger.debug "BookmarksController: Bookmark is created;"
            flash.now[:notice] = "Bookmark has been saved!"
        else
            logger.debug "BookmarksController: Could not create bookmark, it has missing attributes; bookmark='#{@bookmark.inspect}'"
            flash.now[:error] = "Bookmark has missing attributes!"
        end
        render :action => :new
    end

    def show
        @bookmark = Bookmark.find_by_id(params[:id])
        unless @bookmark
            logger.error "BookmarksController: Bookmark is not found; id='%s'" % params[:id]
        end
    end

    def search
        @bookmarks = Bookmark.search(params[:id]) || []
    end

end
