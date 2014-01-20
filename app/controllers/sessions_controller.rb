class SessionsController < ApplicationController
  def new
    redirect_to user_path(current_user) if logged_in?
  end

  def create
    user = User.find_by(username: login_params[:username])

    if user && user.authenticate(login_params[:password])
      if user.two_factor?
        session[:two_factor] = true
        user.generate_pin!
        user.send_pin_to_twilio
        redirect_to pin_path
      else
        login_user!(user)
      end
    else
      flash.now[:error] = 'Username/password combination do not match.'
      render :new
    end
  end

  def pin
    access_denied unless session[:two_factor]

    if request.post?
      user = User.find_by(pin: params[:pin])

      if user
        session[:two_factor] = nil
        user.remove_pin!
        login_user!(user)
      else
        flash[:error] = 'There was something wrong with the pin number you entered.'
        redirect_to pin_path
      end
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'You were logged out successfully.'
    redirect_to posts_path
  end

  private
  def login_params
    params.permit(:username, :password)
  end
end
