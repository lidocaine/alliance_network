require 'spec_helper'

describe User do
  before(:each) do
    @attr = { :username => "TestUser",
              :first_name => "Testimus",
              :last_name => "Userus",
              :email => "testing@example.com" }
  end
  
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end
  
  describe "tests on usernames" do
    it "should require a username" do
      no_uname_user = User.new(@attr.merge(:username => ""))
      no_uname_user.should_not be_valid
    end
  
    it "should reject short usernames" do
      short_uname = "a" * 2
      short_uname_user = User.new(@attr.merge(:username => short_uname))
      short_uname_user.should_not be_valid
    end
    
    it "should reject long usernames" do
      long_uname = "a" * 26
      long_uname_user = User.new(@attr.merge(:username => long_uname))
      long_uname_user.should_not be_valid
    end
    
    it "should reject usernames with spaces and/or special characters" do
      invalid_uname = ')!#@{ $%^ &*('
      invalid_uname_user = User.new(@attr.merge(:username => invalid_uname))
      invalid_uname_user.should_not be_valid
    end
    
    it "should reject duplicate usernames" do
      User.create!(@attr.merge(:first_name => "Tester",
                               :last_name => "Userer",
                               :email => "testing2@example.com"))
      duplicate_uname_user = User.new(@attr)
      duplicate_uname_user.should_not be_valid
    end
    
    it "should reject duplicate usernames up to case" do
      upcased_uname = @attr[:username].upcase
      User.create!(@attr.merge(:username => upcased_uname, 
                               :first_name => "Tester",
                               :last_name => "Userer",
                               :email => "testing2@example.com"))
      duplicate_uname_user = User.new(@attr)
      duplicate_uname_user.should_not be_valid
    end
  end
  
  describe "tests on first names" do
    it "should require a first name" do
      no_first_name_user = User.new(@attr.merge(:first_name => ""))
      no_first_name_user.should_not be_valid
    end
  
    it "should reject long first names" do
      long_first_name = "a" * 51
      long_first_name_user = User.new(@attr.merge(:first_name => long_first_name))
      long_first_name_user.should_not be_valid
    end
    
    it "should reject first names with spaces and/or special characters"
  end
  
  describe "tests on last names" do
    it "should require a last name" do
      no_last_name_user = User.new(@attr.merge(:last_name => ""))
      no_last_name_user.should_not be_valid
    end
    
    it "should reject long last names" do
      long_last_name = "a" * 51
      long_last_name_user = User.new(@attr.merge(:last_name => long_last_name))
      long_last_name_user.should_not be_valid
    end
    
    it "should reject last names with spaces and/or special characters"
  end
  
  describe "tests on email addresses" do
    it "should require an email address" do
      no_email_user = User.new(@attr.merge(:email => ""))
      no_email_user.should_not be_valid
    end
  
    pending "should accept valid email addresses" do
      addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp double.tdl@freak.co.jp]
      addresses.each do |address|
        valid_email_user = User.new(@attr.merge(:email => address))
        valid_email_user.should be_valid
      end
    end
    
    it "should reject invalid email addresses" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |address|
        invalid_email_user = User.new(@attr.merge(:email => address))
        invalid_email_user.should_not be_valid
      end
    end
    
    it "should reject duplicate email addresses" do
      User.create!(@attr.merge(:username => "TestUser2",
                               :first_name => "Tester",
                               :last_name => "Userer"))
      duplicate_email_user = User.new(@attr)
      duplicate_email_user.should_not be_valid
    end
    
    it "should reject duplicate email addresses regardless of case" do
      upcase_email = @attr[:email].upcase
      User.create!(@attr.merge(:username => "TestUser2",
                               :first_name => "Tester",
                               :last_name => "Userer"))
      duplicate_email_user = User.new(@attr.merge(:email => upcase_email))
      duplicate_email_user.should_not be_valid
    end
  end
  
end