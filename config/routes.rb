Rails.application.routes.draw do
  root to: "classrooms#index"

  resources :classrooms do 
    member do
      get 'enroll'
      get 'enrolled'
    end

    collection do
      get 'my_classes'
    end
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
