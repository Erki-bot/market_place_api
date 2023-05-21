require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test 'should show user' do
    get api_v1_user_url(@user), as: :json

    assert_response :success
    # Test if the response contains the correct email

    json_response = JSON.parse(self.response.body)
    assert_equal @user.email, json_response['email']
  end


  test "should create user" do
    assert_difference ('User.count') do
      post api_v1_users_url , params: {
        user: {
        email: "test2@example.com",
        password: "12345",
      }}, as: :json
    end

    assert_response :created
  end

  test "shouldn't create user with taken email" do
    assert_no_difference('User.count') do
      post api_v1_users_url, params:{
          user:{
            email: @user.email,
            password:'12345'
          }
        }, as: :json
    end
    assert_response :unprocessable_entity
  end

  test "should update user" do
    patch api_v1_user_url(@user), params:{
      user:{ email: @user.email, password:"@user.password"}}, as: :json
    assert_response :ok
  end

  test "shouldn't update user with invalid email" do
    put api_v1_user_url(@user),
      params:{user:{ email:"sks",password:"qsjiss"}}, as: :json

    assert_response :unprocessable_entity
  end

  test "should delete a user" do
    assert_difference('User.count',-1) do
      delete api_v1_user_url(@user), as: :json
    end
    assert_response :no_content
  end
end
