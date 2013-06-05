NewsSystem::Application.routes.draw do
  devise_for :users

  root to: 'news#index'
  resources :news do
    put :vote, on: :member
    get "my", to: "news#my", on: :collection
  end
end
