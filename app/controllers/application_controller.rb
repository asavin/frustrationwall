class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :initialize_public_variables
  
  def initialize_public_variables
    @frustration = Frustration.new
  end
end
