require "test_helper"

class SignupUserTest < ActionDispatch::IntegrationTest
  test 'get new user form and create user' do
    get '/signup'
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: {username: "johndoe", email: "johndoe@example.com", password: "password"}}
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "johndoe", response.body
  end

  test 'get new user form and reject invalid user submission ' do
    get '/signup'
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: {username: " ", email: " ", password: " "  } }
    end
    assert_match 'errors', response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end

end
