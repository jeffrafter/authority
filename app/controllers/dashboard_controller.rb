class DashboardController < ApplicationController
  before_filter :require_user
  resource_controller  
  actions :show
end
