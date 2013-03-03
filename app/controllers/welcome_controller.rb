class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to welcome_logged_in_path
    end
  end

  def logged_in
  end
end
