module NewsHelper
  def button_to_vote_news(id)
    if @news.user_vote?(session[:session_id])
      button_to "Уже голосовали", vote_news_path(id), class: "btn disabled", disabled: true
    else
      button_to "Голосовать", vote_news_path(id), method: :put, remote: true, class: "btn"
    end
  end
end
