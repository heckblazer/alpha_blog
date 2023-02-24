class ArticlesController < ApplicationController
  
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def show
  end
  
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end
  
  def create
    # This includes whitelisting the params that are passed into the method
    @article = Article.new(title_description)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article saved successfully"
      #redirect_to action: 'index'
      #redirect_to article_path(@article)
      redirect_to @article
    else
      render 'new'
    end
    
  end
  
  def new
    @article = Article.new
  end
  
  def edit
    
  end
  
  def update
    if @article.update(title_description)
      flash[:success] = "Article updated successfully"
      redirect_to @article
    else  
      render 'edit'
    end
  end
  
  def destroy
    @article.destroy
    redirect_to articles_path
  end 
  
  private
  
  def set_article
    @article = Article.find(params[:id])
  end
  
  def title_description
    params.require(:article).permit(:title, :description)
  end
  
  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:error] = "You can only edit or delete your own articles"
      redirect_to @article
    end
  end
  
end