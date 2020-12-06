class Messages::MessageEditController < ApplicationController
  def index
    message = Message.find_by(id: params[:id])

    if params[:delete_flg] 
      message.destory!
      fl_msg = '削除完了しました。'
    else
      message.update!(is_sent: true)
      fl_msg = '配信完了しました。'
    end

    render json: {fl_msg: fl_msg}
  end
end