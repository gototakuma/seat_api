module JwtAuthenticator
  require "jwt"

  SECRET_KEY_BASE = ENV['SECRET_KEY']

  def jwt_authenticate
    raise UnableAuthorizationError.new("認証情報が不足しています。") if request.headers['Authorization'].blank?
    encoded_token = request.headers['Authorization'].split('Token ').last
    payload = decode(encoded_token)
    @current_user = User.find_by(id: payload[:uid])
    raise UnableAuthorizationError.new("認証できません。") if @current_user.blank?
    @current_user
  end

  # 暗号化処理
  def encode(user_id)
    expires_in = 12.month.from_now.to_i
    preload = { uid: user_id, exp: expires_in }
    JWT.encode(preload, SECRET_KEY_BASE, 'HS256')
  end

  # 復号化処理
  def decode(encoded_token)
    decoded_dwt = JWT.decode(encoded_token, SECRET_KEY_BASE, true, algorithm: 'HS256')
    decoded_dwt.first
  end

end