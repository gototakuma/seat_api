class Shops::ShopInfoController < ApplicationController
  before_action :jwt

  def index
    if @jwt
      shops = Shop.where(id: @jwt[:id])
    else
      shops = Shop.all
      shops = shops.where('name like ?', "%#{params[:name]}%") if params[:name].present?
      shops = shops.where(id: params[:id]) if params[:id].present?
      shops = shops.where('address like ?', "%#{params[:address]}%") if params[:address].present?
    end

    if shops.present?
      render json: {shops: shops}
    else
      render json: {err_msg: ['店舗情報が存在しません。']}
    end
  end
end