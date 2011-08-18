require 'json'
class EmailsController < ApplicationController
  include ApplicationHelper
  respond_to  :html
  
  # GET /emails
  # GET /emails.xml
  def index
    @emails = JSON[access_token.get("/api/v1/emails").body]
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @emails }
    end
  end

  # GET /emails/1
  # GET /emails/1.xml
  def show
    @email_id = params[:id]
    @email      = JSON[access_token.get("/api/v1/emails/#{@email_id}").body]
    @email_tags = JSON[access_token.get("/api/v1/emails/#{@email_id}/tags").body]
    @tags_obj = JSON[access_token.get("/api/v1/tags").body]
    @attachments = JSON[access_token.get("/api/v1/emails/#{@email_id}/attachments").body]
    @email_text = access_token.get("/api/v1/emails/#{@email_id}/text_body").body
    @email_html = access_token.get("/api/v1/emails/#{@email_id}/html_body").body
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @email }
    end
  end

  # GET /emails/new
  # GET /emails/new.xml
  def new
  end

  # GET /emails/1/edit
  def edit
  end

  # POST /emails
  # POST /emails.xml
  def create
  end

  # PUT /emails/1
  # PUT /emails/1.xml
  def update
  end

  # DELETE /emails/1
  # DELETE /emails/1.xml
  def destroy
    result = access_token.delete("/api/v1/emails/#{params[:id]}")
    display_api_response( result )
    respond_with("",:location => :back)
  end

  def untag
    id = params[:id]
    tag_id = params[:tag_id].sub("-",":")
    puts "aaaa" * 10
    puts "#{id}=> #{tag_id}"
    result = access_token.delete("/api/v1/emails/#{id}/tags/#{tag_id}")
    display_api_response( result )
    respond_with("",:location => :back)
   
  end

  def add_tag
    result = access_token.post("/api/v1/emails/#{params[:id]}/tags/#{params[:tag][:tag_id].sub("-",":")}")
    display_api_response result
    respond_with("",:location => :back)
  end
  
end
