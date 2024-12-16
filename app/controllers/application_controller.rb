class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    authenticated_root_path  # Redireciona para o dashboard
  end
end