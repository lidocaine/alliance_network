class PagesController < ApplicationController
  def home
  end

  def about
    @title = "About"
  end

end
