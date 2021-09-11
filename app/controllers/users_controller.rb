# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    build_user
  end

  def create
    build_user
    save_user or render 'new'
  end

  def edit
    load_user
    build_user
  end

  def update
    load_user
    build_user
    save_user or render 'edit'
  end

  def show
    load_user
  end

  private

  def load_user
    @user ||= user_scope.find(params[:id])
  end

  def build_user
    @user ||= user_scope.build
    @user.attributes = user_params
  end

  def save_user
    @user = ActiveType.cast(@user, Users::Signup)
    if @user.save
      redirect_to @user
    end
  end

  def user_params
    user_params = params[:user]
    user_params ? user_params.permit(:email, :first_name, :last_name, :password, :password_confirmation) : {}
  end

  def user_scope
    User.all
  end
end
