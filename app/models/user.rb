class User < ActiveRecord::Base
  has_many :links
  has_many :trackings
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable # :confirmable, :omniauthable
end
