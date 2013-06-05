class NewsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show, :vote]
  before_filter :current_user_author, only: [:edit, :update, :destroy]

  def index
    news_collection = News.sorted_for_main
    @all_news = NewsDecorator.decorate_collection(news_collection)
  end

  def new
    @news = News.new
  end

  def my
    @all_news = current_user.news.decorate
    render :index
  end

  def create
    @news = News.new(params[:news])
    @news.user = current_user
    @news.save

    respond_with @news
  end

  def show
    @news = News.find(params[:id]).decorate
  end

  def edit
  end

  def update
    if @news.update_attributes(params[:news])
      redirect_to @news, notice: "Успешно обновлено"
    else
      render :edit
    end
  end

  def destroy
    @news.destroy
    redirect_to news_url
  end

  def vote
    @news = News.find(params[:id]).decorate
    
    if session[:session_id] && @news.increase_rating!(session[:session_id])
      respond_to do |format|
        format.html { redirect_to @news, notice: "Успешно проголосовали" }
        format.js {}
      end
    else
      flash[:error] = "Вы уже голосовали" 
      redirect_to @news
    end
  end

  private
  def current_user_author
    @news = current_user.news.where(id: params[:id]).first
    redirect_to root_url if @news.nil?
  end
end
