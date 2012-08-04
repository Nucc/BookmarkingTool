BookmarkingTool::Application.routes.draw do

    resources :bookmarks

    root :to => 'bookmarks#index'

    match ':controller(/:action(/:id))(.:format)'

end
