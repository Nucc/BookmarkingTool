class SitesController < ApplicationController

    def index
        @sites = Site.all
    end

    def show
        @site = Site.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        logger.error "SitesController: Site is not found; id='%s'" % params[:id]
    end

end
