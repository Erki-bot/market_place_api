require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'user with valid email should be valid' do
    user = User.new(email: 'mhz@test.com', password_digest: 'test')
    assert user.valid?
  end

  test 'user with invalid email should not be valid' do
    user = User.new(email: 'mhztest.com', password_digest:'test')

    assert_not user.valid?
  end

  test 'user with taken email should not be valid' do
    old_user = users(:one)
    new_user = User.new(email: old_user.email, password_digest: 'test')
    assert_not new_user.valid?
  end
end
