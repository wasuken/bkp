require 'test_helper'

class Api::JournalControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end
  test "should get index" do
    token = @user.token
    get "/api/journals", headers: { "Authorization" => ('Token ' + token) }
    assert_response :success
  end
  test "should get index failed" do
    get "/api/journals"
    assert_response :unauthorized
  end
end
