class Shops::ShopNewController < ApplicationController
  def index
    
    err_msg = []
    err_msg << '店舗名が入力されていません。' if params[:name].blank?
    err_msg << 'ログインIDが入力されていません。' if params[:login_id].blank?
    err_msg << 'パスワードが入力されていません。' if params[:password].blank?
    err_msg << '住所が入力されていません。' if params[:address].blank?
    render json: {err_msg: err_msg} and return if err_msg.present?

    shop = Shop.new(
      name: params[:name],
      login_id: params[:login_id],
      password: params[:password],
      address: params[:address]
    )
    shop.save!

    render json: {fl_msg: "#{shop.name}を登録しました。"}
  end
end