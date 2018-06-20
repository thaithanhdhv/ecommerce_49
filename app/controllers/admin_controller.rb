class AdminController < ApplicationController
  layout :admin_layout

  def index; end

  private

  def admin_layout
    if logged_in? && current_user.admin?
      Settings.admin_layout
    else
      Settings.app_layout
    end
  end
end
