Rails.application.routes.draw do
  get '/auth/spotify/callback', to: 'user#spotify'

  get 'listen/index'

  root 'listen#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
