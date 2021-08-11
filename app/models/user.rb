class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets, dependent: :destroy
  has_many :likes
  has_many :liked_tweets, :through => :likes, :source => :tweet
  has_many :friends
  
  def is_following?(friend_id)
    self.friends.where(:friend_id => friend_id).exists?
  end

  def arr_friends_id
    friends.map(&:friend_id)
    # friends.pluck(:friend_id)
  end

  def arr_friends_id_and_me
    friends.map(&:friend_id).push(id)
  end

  def friend_count
    friends.count
  end

  def tweets_count
    tweets.count
  end

  def likes_give_it
    likes.count
  end

  def retweet_give_it
    tweets.where.not(rt_ref: nil).count
  end

  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end
end
