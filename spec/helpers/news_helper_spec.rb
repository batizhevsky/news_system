require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the NewsHelper. For example:
#
# describe NewsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe NewsHelper do
  it "button_to_vote_news" do
    @news = FactoryGirl.create :news
    @news.should_receive(:user_vote?)
    helper.button_to_vote_news(1)
  end
end
