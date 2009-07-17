ActionController::Routing::Routes.draw do |map|
  map.resources :users
  map.resources :sessions
  map.resource :account, :controller => "users"
  map.resource :password, :member => {:forgot => :get, :reset => :post}
  map.resource :confirmation
  map.resource :dashboard, :controller => "dashboard"
  map.root :controller => 'welcome', :action => 'show'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.forgot '/forgot', :controller => 'passwords', :action => 'forgot'
end