class User < ActiveRecord::Base
  has_many :news

  devise :database_authenticatable, :registerable

  attr_accessible :email, :password, :password_confirmation
end
