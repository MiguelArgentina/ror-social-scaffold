class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  # This method gets all the User's friends
  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.confirmed }
    friends_array.compact
  end

  # Users who have yet to confirm friend requests
  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  # Users who have requested to be friends
  def friend_requests
    inverse_friendships.map do |friendship|
      friendship.user unless friendship.confirmed || (friendship.creator == id)
    end.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find { |relation| relation.user == user }
    friendship.confirmed = true
    friendship.save

    friendship = friendships.find { |relation| relation.friend == user }
    friendship.confirmed = true
    friendship.save
  end

  def reject_friend(user)
    friendship = inverse_friendships.find { |relation| relation.user_id == user.id }
    friendship.confirmed = false
    friendship.save

    friendship = friendships.find { |relation| relation.friend_id == user.id }
    friendship.confirmed = false
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end
end
