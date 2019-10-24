Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "login" => "users#login_form"
  post "login" => "users#login"

  get "index" => "users#index"

  get "/" => "users#login_form"
end
