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

  get "create" => "schedules#create_form"
  post "schedules/create" => "schedules#create"
  get "show/:year/:month" => "schedules#show"

  get "schedule/list" => "states#list"
  get "released/:year/:month" => "states#released"
  get "unreleased/:year/:month" => "states#unreleased"

  get "index" => "users#index"
  get "/" => "users#index"
end