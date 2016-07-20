class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id unless current_user && current_user.admin?
      if current_user.admin?
        redirect_to admin_users_path, notice: "#{@user.full_name} has been added!"
      else
        redirect_to movies_path, notice: "Welcome aboard #{@user.firstname}!"
      end
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to root_path, notice: "#{@user.full_name}'s details have been updated."
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path, notice: "Account: #{@user.email} has been deleted."
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
  end

end
