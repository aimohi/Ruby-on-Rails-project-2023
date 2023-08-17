class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    return nil if session[:user_id].nil?

    return nil unless User.exists?(params[:id])

    @user = User.find(session[:user_id])
  end
end
