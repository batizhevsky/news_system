class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :news_id
      t.string :user_session
    end
  end
end
