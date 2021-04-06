module UserHelper

  def gravatar_for(user, size: 60)
    gravatar_id = Digest::MD5.hexdigest(user.email)
    user.update(gravatar_url: "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}") if user.gravatar_url.nil?
    image_tag(user.gravatar_url, alt: user.name, class: 'gravatar')
  end

  def create_friendship(friend_id)
    user = User.find_by('id = ?', current_user.id)
    friend = User.find_by('id = ?', friend_id)
    Friendship.create(user: user, friend: friend) unless friend_id.nil?
  end

  def accept(user)
    users_path(user, friend_id: user.id, confirm: true)
  end

  def reject(user)
    users_path(user, friend_id: user.id, confirm: false)
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

  def a_rejected(user)
    rejected_requests = Friendship.all.where(confirmed: false).where(friend_id: current_user.id).pluck(:user_id)
    rejected_requests.include?(user.id)
  end
end
