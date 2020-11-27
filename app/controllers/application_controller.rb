class ApplicationController < ActionController::API
  include JwtAuthenticator
  rescue_from NameError, with: :name_error
  rescue_from JWT::DecodeError, with: :jwt_decode_error

  private

  def jwt_need?
    return params[:jwt]
  end

  def name_error(e)
    render json: {err_msg: ["NameError: #{e}"]}
  end

  def jwt_decode_error(e)
    render json: {err_msg: ["JWT::DecodeError: 認証に失敗しました。"]}
  end
end
