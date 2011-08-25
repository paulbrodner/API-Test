require 'json'
module ApplicationHelper

  # usage:access_token.get('/tags').body for example to get the list of tags
  def access_token
    unless consumer_token.nil?
      return consumer_token.client
    end
  end
 
  def consumer_token
    current_user.doxsite
  end

  def doxsite_user
    JSON[access_token.get('/api/v1/users/current_user').body]
  end
end
