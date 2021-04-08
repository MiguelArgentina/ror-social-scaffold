module UserHelper
  def gravatar_for(user, size: 60)
    gravatar_id = Digest::MD5.hexdigest(user.email)
    user.update(gravatar_url: "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}") if user.gravatar_url.nil?
    image_tag(user.gravatar_url, alt: user.name, class: 'gravatar')
  end

  def create_friendship(friend_id)
    user = User.find_by('id = ?', current_user.id)
    friend = User.find_by('id = ?', friend_id)
    Friendship.create(creator: user.id, user: user, friend: friend) unless friend_id.nil?
    Friendship.create(creator: user.id, user: friend, friend: user) unless friend_id.nil?
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

  def created_request_for?(user)
    Friendship.where(creator: current_user.id).pluck(:friend_id).reject { |req| req == current_user.id }.include?(user.id)
  end

  def a_requested(user)
    current_user.friend_requests.include?(user)
  end


  def all_pending
    rejected = Friendship.all.where(confirmed: false).where(friend_id: current_user.id).pluck(:user_id)
    current_user.friend_requests.reject { |req| rejected.include?(req.id) }
  end

  def all_friends
    current_user.friends
  end

  def a_rejected(user)
    rejected_requests = Friendship.all.where(confirmed: false).where(friend_id: current_user.id).pluck(:user_id)
    rejected_requests.include?(user.id)
  end

  def show_friendship_options(user)
    if a_requested(user) and !created_request_for?(user)
      content_tag(:div) do
        concat(link_to('Accept friend request', accept(user), class: 'd-block my-1 profile-link'))
        concat(link_to('Reject friend request', reject(user), class: 'profile-link'))
      end
    elsif who_to_add(user) && not_pending(user)
      link_to('Invite to friendship', users_path(user, friend_id: user.id), class: 'd-block my-1 profile-link')
    end
  end

  def show_friendship_actions(user)
    if a_requested(user) and !created_request_for?(user)
      content_tag(:div) do
        concat((tag.p 'This user sent a friend request'))
        concat((link_to('Actions', user_path(current_user), class: 'action btn btn-warning')))
      end
    elsif who_to_add(user) && not_pending(user)
      link_to('Invite to friendship', user_path(@user, friend_id: @user.id), class: 'action btn btn-secondary')
    end
  end

  def user_profile(user)
    render 'friendship' if my_profile(user)
  end
end
