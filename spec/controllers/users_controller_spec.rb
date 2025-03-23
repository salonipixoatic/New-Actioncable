require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include Devise::Test::ControllerHelpers  

  before do
    @user = User.create!(email: "saloni@gmail.com", password: "password123")
    @first_user = User.create!(email: "diyu@example.com", password: "password123")
    @third_user = User.create!(email: "test@gmail.com", password: "password123")

    sign_in @user 
  end

  describe "GET #index" do
    it " users with all users except the current user" do
      get :index
      expect(assigns(:users)).to match_array([@first_user, @third_user]) 
    end
  end
end
