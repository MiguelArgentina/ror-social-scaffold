module PostHelper
  def display_errors(post)
    return unless post.errors.full_messages.any?

    content_tag :p, "Post could not be saved. #{post.errors.full_messages.join('. ')}", class: 'errors'
  end

  def my_timeline
    all_posts = @timeline_posts.pluck(:user_id)
    friends_post = current_user.friends.pluck(:id).select { |friend| all_posts.include?(friend) }
    filtered = @timeline_posts.where(user_id: friends_post).or(@timeline_posts.where(user_id: current_user.id))
    render filtered
  end
end
