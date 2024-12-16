  class Devise::SessionsController < Devise::SessionsController
    skip_before_action :verify_authenticity_token, only: :create
  end
  
    def redirect_if_logged_in
      redirect_to dashboard_path if user_signed_in?
    end

    
  end