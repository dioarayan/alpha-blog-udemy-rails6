
require 'test_helper'

class UserTest < ActiveSupport::TestCase

    def setup
        @user = User.new(username: "johndoe", email: "johndoe@example.com", password: "password")
    end

    test "user should be valid" do
        assert @user.valid?
    end

    test "username should be present" do
        @user.username = ""
        assert_not @user.valid?
    end

    test "username should be unique" do 
        @user.save
        @user2 = User.new(username: "johndoe", email: "johndoe@example.com", password: "password")
        assert_not @user2.valid?
    end

    test "username should not be too long" do
        @user.username = "a" * 26
        assert_not @user.valid?
    end

    test "username should not be too short" do
        @user.username = "aa" 
        assert_not @user.valid?
    end

    test "email should be present" do
        @user.email = ""
        assert_not @user.valid?
    end

    test "email should be unique" do 
        @user.save
        @user2 = User.new(username: "johndoe", email: "johndoe@example.com", password: "password")
        assert_not @user2.valid?
    end

    test "email should not be too long" do
        @user.email = "a" * 106
        assert_not @user.valid?
    end

    test "email should follow format" do 
        assert_match(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, @user.email) 
    end


end