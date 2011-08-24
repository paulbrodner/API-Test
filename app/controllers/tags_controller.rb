require 'json'

class TagsController < ApplicationController
  include ApplicationHelper
  respond_to  :html

  before_filter :authenticate_user!
   
  def all
    @tags = get_all_tags
    @tags_obj = JSON[@tags.body]
  end

  def new
  end

  def add
    result = add_tag(params[:tag_name])
    display_api_response result
  end

  def destroy
    id = params["tag"]["id_tag"]
    puts id
    result = access_token.delete("/api/v1/tags/#{id}")
    display_api_response result
    respond_with("",:location => :back)
  end

  private
  
  def get_all_tags
    access_token.get("/api/v1/tags")
  end

  def add_tag(tag_name)
    access_token.post("/api/v1/tags/create", {:name=>tag_name})
  end
end
