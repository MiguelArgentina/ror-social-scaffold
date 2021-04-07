require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:test_user_1)
  end
  
  test 'user name must be present' do
    @user.name = '  '
    assert_not @user.save
  end

  test 'user name should not be more than 20 characters' do
    @user.name = 'a' * 21
    assert_not @user.valid?
  end
end