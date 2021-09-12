# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    build_user
  end

  def create
    if save_user.valid?
      redirect_to next_path(@user)
    else
      render 'new'
    end
  end

  def edit
    load_user
    build_user
  end

  def update
    load_user
    if update_user
      redirect_to done_path
    else
      render 'edit'
    end
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
    @user = Users::Signup.start(user_params)
  end

  def update_user
    @user = Users::Signup.next(@user, user_params)
  end

  def user_params
    user_params = params[:user]
    user_params ? user_params.permit(:email, :first_name, :last_name, :birthday, :gender, :password, :password_confirmation) : {}
  end

  def user_scope
    User.all
  end
end
