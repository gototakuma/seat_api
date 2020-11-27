class SessionController < ApplicationController
  include JwtAuthenticator

  def create
    err_msg = []
    err_msg << 'ログインIDが入力されていません。' if params[:login_id].blank?
    err_msg << 'パスワードが入力されていません。' if params[:password].blank?
    render json: {err_msg: err_msg} and return if err_msg.present?

      if params[:shop_login]
        @login_data = Shop.find_by(login_id: params[:login_id])
        position = 'shop'
      else
        @login_data = User.find_by(login_id: params[:login_id])
        position = 'user'
      end
    if @login_data&.authenticate(params[:password])
      jwt_token = encode(@login_data.id)
      response.headers['X-Authentication-Token'] = jwt_token
      render json: {
        fl_msg: 'ログインしました。',
        token: jwt_token,
        position: position
      }
    else
      render json: {err_msg: ["ログインIDまたはパスワードが誤っています。"]}
    end
  end
end