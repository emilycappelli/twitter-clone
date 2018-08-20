class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
# associate with tweets
 has_many :tweets

# tell them we want an array with the following field
 serialize :following, Array

# for carrierwave
 mount_uploader :avatar, AvatarUploader

 # add validation
 validates :username, presence: true, uniqueness: true
end
