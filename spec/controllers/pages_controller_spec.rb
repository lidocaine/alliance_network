require 'spec_helper'

describe PagesController do
  render_views
  
  before(:each) do
    @app_name = "The Alliance Network"
  end

  describe "GET 'home'" do
    before(:each) do
      get :home
    end
    
    it "should be successful" do
      response.should be_success
    end
    
    it "should have a 'home' link" do
      response.should have_selector("a", :href => root_path, :content => "Home")
    end
    
    it "should have an 'about' link" do
      response.should have_selector("a", :href => about_path, :content => "About")
    end
    
    it "should have a 'sign in' link" do
      response.should have_selector("a", :content => "Sign In")
    end
  end

  describe "GET 'about'" do
    before(:each) do
      get :about
    end
    
    it "should be successful" do
      response.should be_success
    end
    
    it "should have the right title" do
      response.should have_selector("title", :content => @app_name + " | About")
    end
  end

end
