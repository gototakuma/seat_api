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

  #座席
  post '/seat_info', to: 'seats/seat_info#index'
  post '/seat_new', to: 'seats/seat_new#index'
  post '/seat_edit', to: 'seats/seat_edit#index'

  # 利用時間
  post '/utilization_time_new', to: 'utilization_times/utilization_time_new#index'
  post '/utilization_list', to: 'utilization_times/utilization_list#index'
  post '/utilization_history', to: 'utilization_times/utilization_history#index'

  # お知らせ
  post '/message_new', to: 'messages/message_new#index'
  post '/message_info', to: 'messages/message_info#index'
  post '/message_edit', to: 'messages/message_edit#index'
end
