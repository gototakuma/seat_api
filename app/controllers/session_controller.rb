class SessionController < ApplicationController
  include JwtAuthenticator

  def create
    err_msg = []
    err_msg << 'ログインIDが入力されていません。' if params[:login_id].blank?
    err_msg << 'パスワードが入力されていません。' if params[:password].blank?
    render json: {err_msg: err_msg} and return if err_msg.present?

    @current_user = User.find_by(login_id: params[:login_id])
    if @current_user&.authenticate(params[:password])
      jwt_token = encode(@current_user.id)
      response.headers['X-Authentication-Token'] = jwt_token
      render json: {
        fl_msg: 'ログインしました。',
        token: jwt_token,
        position: 'user'
      }
    else
      render json: {err_msg: ["ログインIDまたはパスワードが誤っています。"]}
    end
  end
end