require 'test_helper'

class Api::JournalTypesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_journal_types_index_url
    assert_response :success
  end

end
