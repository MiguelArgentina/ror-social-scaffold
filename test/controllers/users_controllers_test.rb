require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    get '/users/sign_in'
    sign_in users(:testuser1)
    post user_session_url

    # If you want to test that things are working correctly, uncomment this below:
    # follow_redirect!
    # assert_response :success
  end

  test 'should get index after signing in' do
    get root_path
    assert_response :success
  end

  test 'testing html elements in layout' do
    get root_path
    assert_template 'posts/index'
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', users_path
    assert_select 'a[href=?]', destroy_user_session_path
  end

  test 'should get redirected to sign-in if trying to access the posts' do
    sign_out users(:testuser1)
    get posts_path
    assert_redirected_to new_user_session_path
  end
end
