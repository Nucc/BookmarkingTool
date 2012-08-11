class SitesController < ApplicationController

    def index
        @sites = Site.all
    end

    def show
        @site = Site.find_by_id(params[:id])
        unless @site
            logger.error "SitesController: Site is not found; id='%s'" % params[:id]
        end
    end

end
