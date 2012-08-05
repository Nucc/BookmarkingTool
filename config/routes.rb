BookmarkingTool::Application.routes.draw do

    match "/bookmarks/search(/:id)", :controller => :bookmarks, :action => :search
    resources :bookmarks, :only => [:show, :create, :new]

    resources :sites, :only => [:index, :show]

    root :to => 'bookmarks#index'

    match ':controller(/:action(/:id))(.:format)'

end
