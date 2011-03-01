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
  attr_accessor :password
  attr_accessible :username, :first_name, :last_name, :email, :password, :password_confirmation
  
  username_format = /\A([^\W\s]+)\z/i
  
  # For some reason, this regex won't pass the rspec test, though it works fine accord to Rubular
  # email_format = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]{2,6}\z/i
  
  email_format = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :username,    :presence => true,
                          :length => { :within => 3..25 },
                          :format => { :with => username_format },
                          :uniqueness => { :case_sensitive => false }
  validates :first_name,  :presence => true,
                          :length => { :maximum => 50 }
  validates :last_name,   :presence => true,
                          :length => { :maximum => 50 }
  validates :email,       :presence => true,
                          :format => { :with => email_format },
                          :uniqueness => { :case_sensitive => false }
  validates :password,    :presence => true,
                          :length => { :within => 4..18 },
                          :confirmation => true
  
  before_save :encrypt_password
  
  def has_password?(submitted_password)
    self.encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(uname, pass)
    user = find_by_username(uname)
    user && user.has_password?(pass) ? user : nil
  end
  
  private
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
