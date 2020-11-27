Rails.application.routes.draw do
  # ログイン
  post 'user_login', to: 'session#create'
  
  # ユーザー
  post '/user_info', to: 'users/user_info#index'
  post '/user_new', to: 'users/user_new#index'
  post '/user_edit', to: 'users/user_edit#index'

  #店舗
  post '/shop_info', to: 'shops/shop_info#index'
  post '/shop_new', to: 'shops/shop_new#index'
  post '/shop_edit', to: 'shops/shop_edit#index'
end
