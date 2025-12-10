Rottenpotatoes::Application.routes.draw do
  resources :movies do
    collection do
      get 'search_tmdb'
      post 'add_movie'
    end
  end

  root to: 'movies#index'
end
