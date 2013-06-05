class News < ActiveRecord::Base
  belongs_to :user
  has_many :votes

  attr_accessible :body, :title

  validates :title, presence: true
  validates :body, presence: true

  scope :sorted_for_main, -> { order("votes_count DESC, created_at DESC") }

  def increase_rating!(session)
    if user_vote?(session)
      false
    else
      votes.create(user_session: session)
    end
  end

  def user_vote?(session)
    votes.where(user_session: session).any?
  end

  def rating
    votes.count
  end
end
