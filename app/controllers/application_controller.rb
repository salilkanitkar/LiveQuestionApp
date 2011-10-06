class ApplicationController < ActionController::Base
  protect_from_forgery
  after_filter :flash_to_headers
end
