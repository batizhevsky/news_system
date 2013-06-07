app/models/news.rbrequire 'spec_helper'

describe News do
  before(:each) do
    @user = FactoryGirl.create :user
    @news = FactoryGirl.create(:news, user: @user)
  end

  let(:session) { "s0m35e55i0n" }

  it 'count rating' do
    Vote.create(news_id: @news)
    @news.rating.should eq Vote.where(news_id: @news).count
  end

  describe 'check for user vote' do
    it 'if not vote before' do
      @news.user_vote?(session).should be_false
    end

    it 'if allready vote' do
      @news.votes.create(user_session: session)
      @news.user_vote?(session).should be_true
    end
  end

  describe 'increase rating' do
    it 'not vote before' do
      @news.stub(:user_vote?) { false }
      expect {
        @news.increase_rating!(session)
      }.to change(Vote, :count).by(1)
    end
    it 'vote before' do
      @news.stub(:user_vote?) { true }
      expect {
        @news.increase_rating!(session)
      }.to change(Vote, :count).by(0)
    end
  end
end
