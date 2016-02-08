Rails.application.routes.draw do
  get '/home' => 'staticpages#home'
  get '/top' => 'songs#top'

  root 'staticpages#home'

 resources :artists, :songs
end
