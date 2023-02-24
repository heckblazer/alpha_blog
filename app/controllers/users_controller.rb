class UsersController < ApplicationController
  
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end
  
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  
  def create
    # This includes whitelisting the params that are passed into the method
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the Place of Many Things #{@user.username}!"
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
      flash[:success] = "User profile updated successfully"
      redirect_to edit_user_path
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
  
    def require_same_user
    if current_user != @user
      flash[:error] = "You can only edit your own profile"
      redirect_to @user
    end
  end
  
end