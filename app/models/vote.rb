class Vote < ActiveRecord::Base
  belongs_to :news, counter_cache: true
  attr_accessible :user_session
end
