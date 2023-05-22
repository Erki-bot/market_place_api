class AuthenticableTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @authentification = MockController.new
    @jwts = JsonWebToken::JsonWebToken.new
  end

  test "should get user from Authentification token" do
    @authentification.request.headers['Authorization'] =
      @jwts.encode(user_id: @user.id)

      assert_equal @user.id, @authentification.current_user.id
  end

  test "should not get user from empty Authentication token" do
    @authentification.request.headers['Authorization'] = nil
    assert_nil @authentification.current_user
  end
end

class MockController
  include Authenticable
  attr_accessor :request

  def initialize
    mock_request = Struct.new(:headers)
    self.request = mock_request.new({})
  end
end

