require 'spec_helper'

describe NewsController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @news = FactoryGirl.create(:news, user: @user)
    @news_attrs = FactoryGirl.attributes_for(:news)
  end

  describe "GET #index" do
    it "shoulds success" do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe "GET #new" do
    it "should redirect to auth for anonymus" do
      get :new
      expect(response).to be_redirect
    end
    it "shoulds success if logined user" do
      sign_in @user

      get :new
      expect(response).to be_success
    end
  end

  describe "CREATE" do
    it "should not create for for anonym" do
      post :create, @news_attrs.except(:user)

      expect(response).to redirect_to(new_user_session_url)
    end

    it "should redirect to all news if auth" do
      sign_in @user

      post :create, @news_attrs.except(:user)

      expect(response).to be_success
    end
  end

  describe "Show" do
    it "should show single news" do
      get :show, id: @news 
      
      expect(response).to be_success
    end

    it "vote" do
      put :vote, id: @news

      response.should redirect_to @news
    end
  end

  describe "get edit" do
    it "should be success" do
      sign_in @user
      get :edit, id: @news

      expect(response).to be_success
    end
  end

  describe "get user news" do
    it "should be success" do
      sign_in @user
      get :my

      expect(response).to be_success
    end
  end

  describe "put update" do
    it "should be success" do
      sign_in @user
      put :update, id: @news, news: @news_attrs.except(:user)

      response.should redirect_to @news
    end
  end

  describe "delete" do
    it "should be success" do
      sign_in @user
      delete :destroy, id: @news

      response.should redirect_to news_url 
    end
  end

end
