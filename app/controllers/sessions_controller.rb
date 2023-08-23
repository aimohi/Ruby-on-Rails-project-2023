class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by username: params[:username]
    if user.status == nil or user.status == false
      redirect_to signin_path, notice: "Your account is blocked, please contact admin"
    else
      if user&.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to user_path(user), notice: "Welcome back!"
      else
        redirect_to signin_path, notice: "Username and/or password mismatch"
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end
