class UsersController < ApplicationController
  
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def new
    @user = User.new
  end
  
  def create
    # This includes whitelisting the params that are passed into the method
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome to the Place of Many Things #{@user.username}!"
      # redirect_to action: 'index'
      # redirect_to article_path(@article)
      # redirect_to @user
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:notice] = "User profile updated successfully"
      redirect_to @user
    else  
      render 'edit'
    end
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
   def user_params
    params.require(:user).permit(:username, :email, :password)
   end
  
end