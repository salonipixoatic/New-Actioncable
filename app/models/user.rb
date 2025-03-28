class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable 

         has_many :chat_users
         has_many :chats, through: :chat_users
         has_many :messages, dependent: :destroy
end
