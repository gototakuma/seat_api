class Shops::ShopEditController < ApplicationController
  before_action :jwt

  def index

    if params[:delete_flg]

      shop = Shop.find_by(id: @jwt[:id])
      render json: {err_msg: ['店舗情報が見つかりませんでした。']} and return if shop.blank?

      shop.destroy!

      fl_msg = '削除完了しました。'

    else

      err_msg =[]
      err_msg << '店舗名が入力されていません。' if params[:name].blank?
      err_msg << 'ログインIDが入力されていません。' if params[:login_id].blank?
      err_msg << '住所が入力されていません。' if params[:address].blank?
      render json: {err_msg: err_msg} and return if err_msg.present?

      shop = Shop.find_by(id: @jwt[:id])
      render json: {err_msg: ['店舗情報が見つかりませんでした。']} and return if shop.blank?

      shop_update = {
        name: params[:name],
        login_id: params[:login_id],
        address: params[:address]
      }
      shop_update['password'] = params[:password] if params[:password].present?

      shop.update!(shop_update)

      fl_msg = '更新完了しました。'
      
    end

    render json: {fl_msg: fl_msg}
  end
end