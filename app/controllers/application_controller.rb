class ApplicationController < ActionController::Base
  skip_forgery_protection
  handle_api_errors(format: :json_api, backtrace: false)
end
