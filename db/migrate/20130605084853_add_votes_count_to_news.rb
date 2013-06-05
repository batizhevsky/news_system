class AddVotesCountToNews < ActiveRecord::Migration
  def change
    add_column :news, :votes_count, :integer
    News.reset_column_information

    News.all.each do |news|
      News.update_counters(news.id, votes_count: news.votes.length)
    end
  end
end
