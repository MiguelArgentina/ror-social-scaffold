require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:test_user_1)
    @user2 = users(:test_user_2)
  end

  def create_friendship(friend_id, current_user)
    user = User.find_by('id = ?', current_user.id)
    friend = User.find_by('id = ?', friend_id)
    Friendship.create(creator: user.id, user: user, friend: friend) unless friend_id.nil?
    Friendship.create(creator: user.id, user: friend, friend: user) unless friend_id.nil?
  end

  test 'user name must be present' do
    @user.name = '  '
    assert_not @user.save
  end

  test 'user name should not be more than 20 characters' do
    @user.name = 'a' * 21
    assert_not @user.valid?
  end


  test 'a friend accepts a request' do
    create_friendship(@user2.id, @user)
    assert true
  end

end
