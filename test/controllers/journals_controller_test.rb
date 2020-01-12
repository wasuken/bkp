require 'test_helper'

class JournalsControllerTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers
  setup do
    @user = users(:one)
  end
  # test "should get new" do
  #   sign_in(@user)
  #   get journals_new_url
  #   assert_response :success
  # end

  test "should get index" do
    login_as(@user, scope: :user)
    get journals_index_url
    assert_response :success
  end

  # test "should get show" do
  #   sign_in(@user)
  #   get journals_show_url
  #   assert_response :success
  # end

end
