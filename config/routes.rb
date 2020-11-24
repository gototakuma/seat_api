Rails.application.routes.draw do
  # ユーザー
  post '/user_info', to: 'users/user_info#index'
  post '/user_new', to: 'users/user_new#index'
  post '/user_edit', to: 'users/user_edit#index'
end
