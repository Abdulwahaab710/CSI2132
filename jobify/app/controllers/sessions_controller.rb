# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  before_filter :authenticate_user, :except => [:new, :create, :destroy]

  def new; end

  def create
    user = User.find_by_email(email: params[:session][:email].downcase)
    # If the user exists AND the password entered is correct.
    puts session[:user_id]
    if user && user.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      redirect_to '/'
    else
    # If user's login doesn't work, send them back to the login form.
      redirect_to '/login'
    end
  end

  def destory
    session[:user_id] = nil
    redirect_to '/login'
  end
end
