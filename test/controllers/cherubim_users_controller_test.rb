require 'test_helper'

class CherubimUsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get cherubim_users_index_url
    assert_response :success
  end

  test 'should get show' do
    get cherubim_users_show_url
    assert_response :success
  end

  test 'should get new' do
    get cherubim_users_new_url
    assert_response :success
  end
end
