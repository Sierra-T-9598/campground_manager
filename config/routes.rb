Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :campgrounds do
        resources :campsites, only: [:index], controller: 'campground_campsites'
      end
      resources :campsites
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
