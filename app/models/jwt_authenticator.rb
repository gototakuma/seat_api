module JwtAuthenticator
  require "jwt"

  SECRET_KEY_BASE = ENV['SECRET_KEY']

  def jwt
    raise UnableAuthorizationError.new("認証情報が不足しています。") if request.headers['Authorization'].blank?
    encoded_token = request.headers['Authorization'].split('Token ').last
    @jwt = decode(encoded_token).symbolize_keys
  end

  # 暗号化処理
  def encode(id)
    expires_in = 12.month.from_now.to_i
    preload = { id: id, exp: expires_in }
    JWT.encode(preload, SECRET_KEY_BASE, 'HS256')
  end

  # 復号化処理
  def decode(encoded_token)
    decoded_dwt = JWT.decode(encoded_token, SECRET_KEY_BASE, true, algorithm: 'HS256')
    decoded_dwt.first
  end

end