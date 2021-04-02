module UserHelper

  def add_friend
    friendship = Friendship.new(user: current_user.id, friend: @user.id)
  end

  def friend?(user)
    return true if Friendship.find_by(friend: user.id).present?

    false
  end

  def other_user?(user)
    return true if user.id != current_user.id
  end

  def create_friendship(friend_id)
    user = User.find_by('id = ?', current_user.id)
    friend = User.find_by('id = ?', friend_id)
    Friendship.create(user: user, friend: friend) unless friend_id.nil?
  end

end
