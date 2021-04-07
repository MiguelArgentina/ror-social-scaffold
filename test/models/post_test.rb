require 'test_helper'

class PostsTest < ActiveSupport::TestCase
  setup do
    @user = users(:test_user_1)
    @post = Post.new(user_id: @user.id, content: 'My test content')
  end
  
  test 'content of a post must be present' do
    @post.content = '  '
    assert_not @post.save
  end

  test 'length of a post should not exceed 1000 characters' do
    @post.content = 'a' * 1001
    assert_not @post.valid?
  end
end