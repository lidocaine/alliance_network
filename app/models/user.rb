class User < ActiveRecord::Base
  attr_accessible :username, :first_name, :last_name, :email
  
  username_format = /\A([^\W\s]+)\z/i
  email_format = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]{2,3}\z/i
  
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
  
end