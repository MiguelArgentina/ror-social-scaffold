module UserHelper

  def create_friendship(friend_id)
    user = User.find_by('id = ?', current_user.id)
    friend = User.find_by('id = ?', friend_id)
    Friendship.create(user: user, friend: friend) unless friend_id.nil?
  end

  def who_to_add(user)
    user.id != current_user.id and !current_user.friends.include?(user)
  end

  def not_pending(user)
    !current_user.pending_friends.include?(user)
  end

  def my_profile(user)
    current_user.name == user.name
  end

  def a_requested(user)
    current_user.friend_requests.include?(user)
  end

  def all_requests
    current_user.friend_requests.count
  end

  def all_friends
    current_user.friends.count
  end
end
