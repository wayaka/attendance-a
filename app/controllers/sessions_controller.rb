class SessionsController < ApplicationController
  require "date"
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # d = Date.today
    if user && user.authenticate(params[:session][:password])
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to root_url
        # if current_user.admin?
        #   redirect_to root_url
        # else
        #   redirect_to root_url
        #   # redirect_to controller: :time_cards, action: :show, user_id: user.id, year: d.year, month: d.month 
        # end
    else
      flash.now[:danger] = 'メールアドレスとパスワード の組み合わせが不正です。'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  
end
