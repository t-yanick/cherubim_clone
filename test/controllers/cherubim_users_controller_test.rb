require "test_helper"

class CherubimUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get cherubim_users_show_url
    assert_response :success
  end
end
