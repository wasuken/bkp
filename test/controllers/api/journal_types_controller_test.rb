require 'test_helper'

class Api::JournalTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @journal_type = journal_types(:one)
  end
  test "should get index" do
    get "/api/journal_types"
    assert_response :success
  end
end
