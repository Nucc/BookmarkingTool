BookmarkingTool::Application.routes.draw do

    resources :bookmarks, :only => [:show, :create, :new]

    root :to => 'bookmarks#index'

    match ':controller(/:action(/:id))(.:format)'

end
