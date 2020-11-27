class Users::UserEditController < ApplicationController
  def index

    if params[:delete_flg]

      user = User.find_by(id: params[:id])
      render json: {err_msg: ['顧客情報が見つかりませんでした。']} and return if user.blank?

      user.destroy!

      fl_msg = '削除完了しました。'

    else

      err_msg = []
      err_msg << '名前が入力されていません。' if params[:name].blank?
      err_msg << 'ログインIDが入力されていません。' if params[:login_id].blank?
      render json: {err_msg: err_msg} and return if err_msg.present?
  
      user = User.find_by(id: params[:id])
      render json: {err_msg: ['顧客情報が見つかりませんでした。']} and return if user.blank?
  
      user_update = {
        name: params[:name],
        login_id: params[:login_id]
      }
      user_update['password'] = params[:password] if params[:password].present?
  
      user.update!(user_update)
  
      fl_msg = '更新完了しました。'
    end

    render json: {fl_msg: fl_msg}
  end
end