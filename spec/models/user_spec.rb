require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Associations" do
    it { should have_many(:chat_users) } 
    it { should have_many(:chats).through(:chat_users) }
    it { should have_many(:messages).dependent(:destroy) }
  end

  describe "Validations" do
    it "is valid with a valid email and password" do
      user = User.new(email: "saloni@gmail.com", password: "saloni@123")
      expect(user).to be_valid
    end

    it "is invalid without a password" do
      user = User.new(email: "test@example.com", password: nil)
      expect(user).not_to be_valid
    end

    it "not allow duplicate emails" do
      User.create!(email: "test@example.com", password: "password123")
      duplicate_user = User.new(email: "test@example.com", password: "password456")
      expect(duplicate_user).not_to be_valid
    end
  end
end
