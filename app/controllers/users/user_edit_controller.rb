class Users::UserEditController < ApplicationController
  def index
    user = User.find_by(id: params[:id])
    render json: {err_msg: ['顧客情報が見つかりませんでした。']} and return if user.blank?

    user_data = {
      name: params[:name],
      login_id: params[:login_id]
    }
    user_data['password'] = params[:password] if params[:password].present?

    user.update!(user_data)

    render json: {fl_msg: '更新完了しました。'}

  end
end