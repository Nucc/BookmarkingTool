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
            logger.debug "BookmarksController: Bookmark is created;"

        rescue ActiveRecord::RecordInvalid
            logger.debug "BookmarksController: Could not create bookmark, it has missing attributes; bookmark='#{@bookmark.inspect}'"
            flash.now[:error] = "Bookmark has missing attributes!"

        rescue Exception => e
            logger.error "BookmarksController: Could not create bookmark; reason='#{e}'"
        end
        render :action => :new
    end

    def show
        @bookmark = Bookmark.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        logger.error "BookmarksController: Bookmark is not found; id='%s'" % params[:id]
    end

    def search
        @bookmarks = Bookmark.search(params[:id])
    rescue Exception => e
        @bookmarks = []
        logger.error "BookmarksController: Search has failed; error='%s'" % e.inspect
    end

end
