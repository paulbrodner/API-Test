class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_one :doxsite, :class_name=>"DoxsiteToken", :dependent=>:destroy
  # the one bellow is just for testing
  has_one :oauth2_test, :class_name=>"Oauth2Token", :dependent=>:destroy
end


