class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user && user.authenticate(session_params[:password])
      log_in user
      redirect_to tasks_path, success: 'success'
    else
      flash.now[:danger] = 'faild'
      render :new
    end
  end

  def destroy
    log_out
    redirect_to login_url, info: 'logged out'
  end

  private

    def session_params
      params.require(:session).permit(:email, :password)
    end

    def log_in(user)
      session[:user_id] = user.id
    end

    def log_out
      session.delete(:user_id)
      flash[:success] = "logged out successfully."
      @current_user = nil
    end
end
