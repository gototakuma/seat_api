class ApplicationController < ActionController::API
  include JwtAuthenticator
  rescue_from NameError, with: :name_error
  rescue_from JWT::DecodeError, with: :jwt_decode_error
  rescue_from ActiveRecord::RecordInvalid, with: :validate_error

  private
  
  def name_error(e)
    render json: {err_msg: ["NameError: #{e}"]}
  end

  def jwt_decode_error(e)
    render json: {err_msg: ["JWT::DecodeError: 認証に失敗しました。"]}
  end

  def validate_error(e)
    render json: {err_msg: [e.to_s.gsub!("バリデーションに失敗しました: ", "").split(",")]}
  end
end
