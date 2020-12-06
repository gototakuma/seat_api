class Messages::MessageNewController < ApplicationController
  before_action :jwt
   
  def index
    err_msg = []
    err_msg << 'タイトルが入力されていません。' if params[:title].blank?
    err_msg << '本文が入力されていません。' if params[:description].blank?
    render json: {err_msg: err_msg} and return if err_msg.present?

    is_sent = 
      params[:is_sent] ? true : false
    message_new = Message.new(
      title: params[:title],
      description: params[:description],
      is_sent: is_sent,
      shop_id: @jwt[:id]
    )
    message_new.save!

    render json: {fl_msg: 'メッセージを登録しました。'}
  end
end