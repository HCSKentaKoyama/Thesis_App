Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"

  get "new" => "users#add_form"
  post "users/insert" =>"users#insert"
  get "list" => "users#list"
  get "edit/:userid" => "users#edit"
  post "update" => "users#update"

  get "entry" => "requests#entry_form"
  post "requests/entry" => "requests#entry"

  get "index" => "users#index"
  get "/" => "users#index"
end
