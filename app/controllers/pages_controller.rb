class PagesController < ApplicationController
  def home
    redirect_to dashboard_path if signed_in?
  end

  def about
    @title = "About"
  end

end
