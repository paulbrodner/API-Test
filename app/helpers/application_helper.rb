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
end
