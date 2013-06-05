class NewsDecorator < Draper::Decorator
  delegate_all

  def author_email
    user.email
  end

  def get_rating
    votes.count || 0
  end
end
