class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[update show]

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)

    # if @user.save
    #   render json: @user, status: :created
    # else
    #   render json: @user.errors, status: :unprocessable_entity
    # end

    @user.save!
    render json: @user, status: :created

  rescue
    render json: @user.errors, status: :unprocessable_entity
  end

  def update
    @user.update!(user_params)

    render json: @user, status: :ok

    rescue
      render json: @user.errors, status: :unprocessable_entity
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
