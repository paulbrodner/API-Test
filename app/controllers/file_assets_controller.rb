require 'rubygems'
require 'json'
require 'rest_client'

class FileAssetsController < ApplicationController
  include ApplicationHelper
  respond_to  :html

  before_filter :authenticate_user!
  
  # GET /file_assets
  # GET /file_assets.xml
  def index
    @file_assets = JSON[access_token.get("/api/v1/file_assets").body]
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @file_assets }
    end
  end

  # GET /file_assets/1
  # GET /file_assets/1.xml
  def show
    @fa_id=setup_id
    @file_asset = JSON(access_token.get("/api/v1/file_assets/#{@fa_id}").body)
    @tags_obj = JSON[access_token.get("/api/v1/tags").body]
    @file_asset_tags = JSON[access_token.get("/api/v1/file_assets/#{@fa_id}/tags").body]
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @file_asset }
    end
  end

  # GET /file_assets/new
  # GET /file_assets/new.xml
  def new
  end

  # GET /file_assets/1/edit
  def edit
    #@file_asset = FileAsset.find(params[:id])
  end

  # POST /file_assets
  # POST /file_assets.xml
  def create
    # this post requires authentication so i send the current access_token
    RestClient.add_before_execution_proc do |req, params|
      access_token.sign! req
    end
    RestClient.post "http://#{Rails.my.www_domain}/api/v1/file_assets/create", :file_asset =>params["file"]
    #with access token doesn't work
    #@file_asset = access_token.post('/api/v1/file_assets/create', {:file_asset=>params["file"]})
    flash[:notice] = "Operation terminated. Check if the file is uploaded on Doxsite (testing)"
    respond_with("",:location => :back)
  end

  # PUT /file_assets/1
  # PUT /file_assets/1.xml
  def update
  end

  # DELETE /file_assets/1
  # DELETE /file_assets/1.xml
  def destroy
    puts "delete --" * 10
    result = access_token.delete("/api/v1/file_assets/#{params[:id]}")

    display_api_response( result )
    
    respond_to do |format|
      format.html { redirect_to(file_assets_url) }
      format.xml  { head :ok }
    end
  end

  def add_tag
    result = access_token.post("/api/v1/file_assets/#{setup_id}/tags/#{setup_tag_id}")
    display_api_response result
    respond_with("",:location => :back)
  end


  def untag
    result = access_token.delete("/api/v1/file_assets/#{setup_id}/tags/#{params[:tag_id]}")
    display_api_response( result )
    respond_with("",:location => :back)
  end

  private

  def setup_id
    params[:id]
  end

  def setup_file
    params[:file]
  end
    
  def setup_tag_id
    params[:tag][:tag_id].sub("-",":")
  end

end
