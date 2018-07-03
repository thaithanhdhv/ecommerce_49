class AdminController < ApplicationController
  layout "admin"
  before_action :is_admin
end
