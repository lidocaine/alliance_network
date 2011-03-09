# == Schema Information
# Schema version: 20110201212836
#
# Table name: users
#
#  id                 :integer(4)      not null, primary key
#  username           :string(255)
#  first_name         :string(255)
#  last_name          :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#

require 'digest'
class User < ActiveRecord::Base
  attr_accessor :password, :update_type
  attr_accessible :username, :first_name, :last_name, :email, :password, :password_confirmation
  
  has_many :authentications
  
  username_format = /^[A-Za-z0-9_-]+$/
  
  # For some reason, this regex won't pass the rspec test, though it works fine accord to Rubular
  email_format = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]{2,6}\z/i
  
  validates_presence_of   :username, :first_name, :last_name, :email
  validates :username,    :length => { :maximum => 30 },
                          :format => { :with => username_format },
                          :uniqueness => { :case_sensitive => false }
  validates :first_name,  :length => { :maximum => 50 }
  validates :last_name,   :length => { :maximum => 50 }
  validates :email,       :format => { :with => email_format },
                          :uniqueness => { :case_sensitive => false }
  validates :password,    :length => { :within => 4..18 },
                          :confirmation => true,
                          :presence => true,
                          :if => :noexist_or_update_password
                                                      
  before_save :encrypt_password, :if => :noexist_or_update_password
  
  def has_password?(submitted_password)
    self.encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(uname, pass)
    user = find_by_username(uname)
    user && user.has_password?(pass) ? user : nil
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  def update_attributes_nosave(attributes)
    attributes.each do |key, value|
      self.send("#{key}=", value)
    end
  end

  private
    # Returns true if the user is issuing a password change request specifically (WIP)
    # or if the user doesn't already have a password (as is the case when creating a user).
    def noexist_or_update_password
      !self.respond_to?(:encrypted_password) || self.encrypted_password.nil?
    end
    
    def encrypt_password
      self.salt = salted if new_record?
      self.encrypted_password = encrypt(password)
    end
    
    def encrypt(string)
      s_hash("#{salt}--#{string}")
    end
    
    def salted
      s_hash("#{Time.now.utc}--#{password}")
    end
    
    def s_hash(string)
      Digest::SHA2.hexdigest(string)
    end
  
end
