module Authenticable

  def current_user
    jwts = JsonWebToken::JsonWebToken.new
    return @current_user if @current_user

    header = request.headers['Authorization']

    return nil if header.nil?

    decoded = jwts.decode(header)
    @current_user = User.find(decoded[:user_id])


  end
end
