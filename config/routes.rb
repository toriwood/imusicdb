Rails.application.routes.draw do
  get '/home' => 'staticpages#home'

  root 'staticpages#home'

 resources :artists, :songs
end
