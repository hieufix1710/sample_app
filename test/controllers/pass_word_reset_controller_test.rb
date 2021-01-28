require "test_helper"

class PassWordResetControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get pass_word_reset_new_url
    assert_response :success
  end

  test "should get edit" do
    get pass_word_reset_edit_url
    assert_response :success
  end
end
