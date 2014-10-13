class User < ActiveRecord::Base
  has_many :links
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable # :confirmable, :omniauthable
end
