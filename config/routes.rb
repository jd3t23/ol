Rails.application.routes.draw do
  resources :businesses, only: [:index, :show]
  get '*unmatched_route', to: 'application#resource_not_found'
end
