require 'oauth2'
class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from OAuth2::Error do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  rescue_from Errno::ECONNREFUSED do |ex|
    flash[:error] = ex.message
    redirect_to root_url
  end

  rescue_from JSON::ParserError do |ex|
    flash[:error] = "Error: #{ex.message}"
    redirect_to root_url
  end

  def display_api_response(response)
    puts response
    if response.is_a? Net::HTTPOK or response.body.include?("200")
      flash[:notice] = response.body
    else
      flash[:error] = response.body
    end
  end
  
end
