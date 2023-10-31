require 'test_helper'

class CherubimUserControllerTest < ActionDispatch::IntegrationTest
  test 'should get login' do
    get cherubim_user_login_url
    assert_response :success
  end

  test 'should get signup' do
    get cherubim_user_signup_url
    assert_response :success
  end
end
