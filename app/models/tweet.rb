class Tweet < ApplicationRecord
#associate with user	
	belongs_to :user

# add validation to tweets
	validates :message, presence: true
	validates :message, length: {maximum: 250, too_long: "Your tweet is too long."}
end
