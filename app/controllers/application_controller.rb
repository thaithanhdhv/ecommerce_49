class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def check_valid? id
    redirect_to root_path unless id
  end
end
