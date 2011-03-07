class MicropostsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => [:destroy]
  
  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save!
      flash[:success] = "Status updated!"
      redirect_back_or root_path
    else
      flash[:error] = "Invalid post data..."
      redirect_back_or root_path
    end
  end

  def destroy
    @micropost.destroy
    redirect_back_or root_path
  end

  private
    # Keep users from deleting other's microposts (unless admin)
    def authorized_user
      @micropost = Micropost.find(params[:id])
      redirect_to root_path unless current_user?(@micropost.user) || current_user.admin?
    end
end
