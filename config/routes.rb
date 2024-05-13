Rottenpotatoes::Application.routes.draw do
  # map '/' to be a redirect to '/movies'
  root to: redirect('/movies')
  resources :movies do
    member do
      get 'find_same_director', to: 'movies#find_same_director', as: 'find_same_director'
      get 'similar_movies', to: 'movies#similar_movies', as: 'similar_movies'
    end
  end
end