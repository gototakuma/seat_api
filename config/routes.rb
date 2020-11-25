Rails.application.routes.draw do
  # ログイン
  post 'user_login', to: 'session#create'
  
  # ユーザー
  post '/user_info', to: 'users/user_info#index'
  post '/user_new', to: 'users/user_new#index'
  post '/user_edit', to: 'users/user_edit#index'
end
