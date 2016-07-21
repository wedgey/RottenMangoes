class Admin::UsersController < UsersController
  before_action :require_admin, except: [:unpreview]

  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def preview
    session[:preview] = params[:id]
    redirect_to root_path, notice: "You are now using the site as user #{current_user.email}"
  end

  def unpreview
    session.delete(:preview)
    redirect_to root_path, notice: "You are no longer in preview mode."
  end

  private 

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end

  def require_admin
    unless current_user.admin?
      redirect_to root_path, notice: "You must be an admin to access this page."
    end
  end

end
