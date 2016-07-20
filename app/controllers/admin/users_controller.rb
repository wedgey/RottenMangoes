class Admin::UsersController < ApplicationController
  before_action :require_admin

  def index
    @users = User.all.page(params[:page]).per(10)
  end

  private 
  def require_admin
    unless current_user.admin?
      # session[:alert] = "You must be an admin to access this page."
      redirect_to root_path, notice: "You must be an admin to access this page."
    end
  end

end
