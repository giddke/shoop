# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate, only: %i[index update]
  def index
    @users = User.page(pagination_params[:page]).per(pagination_params[:limit])

    with_pagination_options(@users) do |options|
      render json: UserSerializer.new(@users, options)
    end
  end

  def create
    @user = User.new(create_user_params)

    @user.save!

    render json: @user, status: :created
  end

  def update
    @user = User.find(params[:id])

    render json: @user if @user.update(user_params)

    render json: @user.errors
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone)
  end

  def create_user_params
    params.require(:user).permit(:password).merge user_params
  end
end
