ActionController::Routing::Routes.draw do |map|
  map.resources :changesets
  map.rev_browser 'browser/:rev/*paths', :controller => 'browser', :action => 'index', :rev => /r\d+/
  map.browser 'browser/*paths', :controller => 'browser', :action => 'index'
  map.history 'history/*paths', :controller => 'history', :action => 'index'
  map.root :controller => "dashboard"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end