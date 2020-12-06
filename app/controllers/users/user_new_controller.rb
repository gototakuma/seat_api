class Users::UserNewController < ApplicationController
  def index
    err_msg = []
    err_msg << '名前が入力されていません。' if params[:name].blank?
    err_msg << 'パスワードが入力されていません。' if params[:password].blank?
    err_msg << 'ログインIDが入力されていません。' if params[:login_id].blank?
    render json: {err_msg: err_msg} and return if err_msg.present?

    user = User.new(
      name: params[:name],
      login_id: params[:login_id],
      password: params[:password]
    )
    user.save!

    render json: {fl_msg: '登録完了しました。'}
  end
end