class Messages::MessageInfoController < ApplicationController
  before_action :jwt

  def index

    shops = []
    message_data = []
    sent = []
    not_sent = []
    if params[:user_flg]

      messages = Message.where(is_sent: true).limit(20)
      render json: {err_msg: 'お知らせ内容が見つかりませんでした。'} and return if messages.blank?

      shop_ids = messages.pluck(:shop_id)
      shops = Shop.where(id: shop_ids).select(:id, :name)

      messages.each do |message|
        shop = shops.find{|s| message[:shop_id] == s.id}
        message_data << {
          id: message.id,
          shop_id: message.shop_id,
          title: message.title,
          description: message.description,
          is_sent: message.is_sent,
          shop_name: shop.name,
          created_at: I18n.l(message.created_at, format: :default)
        }
      end

    else
      messages = Message.where(shop_id: @jwt[:id]).limit(20)
      render json: {err_msg: 'お知らせ内容が見つかりませんでした。'} and return if messages.blank?

      messages.each do |message|
        if message.is_sent
          sent << {
            id: message.id,
            shop_id: message.shop_id,
            title: message.title,
            description: message.description,
            is_sent: message.is_sent,
            updated_at: I18n.l(message.updated_at, format: :default)
          }
        else
          not_sent << {
            id: message.id,
            shop_id: message.shop_id,
            title: message.title,
            description: message.description,
            is_sent: message.is_sent,
            created_at: I18n.l(message.created_at, format: :default)
          }
        end
      end
    end
    render json: {messages: message_data, sent: sent, not_sent: not_sent}
  end
end