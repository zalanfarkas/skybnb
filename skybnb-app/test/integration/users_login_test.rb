require 'test_helper'
class UsersLoginTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  def setup
    @user = users(:host)
  end

  test "login with valid information followed by logout" do
    get new_user_session_path
    sign_in users(:host), scope: :user
    assert_select "a[href=?]", destroy_user_session_path
    assert_select "a[href=?]", user_path(@user)
    delete destroy_user_session_path
    # Simulate a user clicking logout in a second window.
    delete destroy_user_session_path
    follow_redirect!
    assert_select "a[href=?]", new_user_session_path
    assert_select "a[href=?]", destroy_user_session_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

end


