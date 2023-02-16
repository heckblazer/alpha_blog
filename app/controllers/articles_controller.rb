class ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id])
  end
  def index
    @articles = Article.all
  end
  def create
    # This includes whitelisting the params that are passed into the method
    @article = Article.new(params.require(:article).permit(:title, :description))
    if @article.save
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
end