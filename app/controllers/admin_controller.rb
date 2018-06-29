class AdminController < ApplicationController
  layout "admin"
  before_action :logged_in_user
end
