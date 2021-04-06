module UserHelper
  def gravatar_for(user, size: 60)
    gravatar_id = Digest::MD5.hexdigest(user.email)
    user.update(gravatar_url: "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}") if user.gravatar_url.nil?
    image_tag(user.gravatar_url, alt: user.name, class: 'gravatar')
  end
end
