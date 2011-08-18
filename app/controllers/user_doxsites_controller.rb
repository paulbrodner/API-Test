require 'json'

class UserDoxsitesController < ApplicationController
  include ApplicationHelper
  respond_to  :html

  # GET /user_doxsites
  # GET /user_doxsites.xml
  def index
  end

  # GET /user_doxsites/1
  # GET /user_doxsites/1.xml
  def show
  end

  # GET /user_doxsites/new
  # GET /user_doxsites/new.xml
  def new
  end

  # GET /user_doxsites/1/edit
  def edit
  end

  # POST /user_doxsites
  # POST /user_doxsites.xml
  def create
    result = access_token.post('/api/v1/users/create', {:email=>params[:email],:psw=>params[:password],:psw_conf=>params[:password_conf],:inbox=>params[:inbox]})
    display_api_response result
    respond_with("",:location => :back)
  end

  # PUT /user_doxsites/1
  # PUT /user_doxsites/1.xml
  def update
  end

  # DELETE /user_doxsites/1
  # DELETE /user_doxsites/1.xml
  def destroy
  end
end
