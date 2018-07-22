class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]
  validates :fullname, presence: true, length: {maximum: 50}
  validates :user_type, presence: true, inclusion: { in: %w(guest host), message: "%{value} is not a valid value" }
  
  has_many :rooms
  has_many :reservations
  has_many :reviews
  has_many :user_photos

  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first
    if user
      return user
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
          user.fullname = auth.info.name
          user.provider = auth.provider
          user.uid = auth.uid
          user.email = auth.info.email
          user.image = auth.info.image
          user.password = Devise.friendly_token[0,20]
          user.user_type = "guest"
      end
    end
  end
  
end
