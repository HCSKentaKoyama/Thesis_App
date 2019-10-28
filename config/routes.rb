Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"

  get "index" => "users#index"

  get "/" => "users#index"
end
