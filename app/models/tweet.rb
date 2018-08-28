class Tweet < ApplicationRecord
#associate with user	
	belongs_to :user

	has_many :tweet_tags
	has_many :tags, through: :tweet_tags

# add validation to tweets
	# this makes sure link counts as no more than 23 characters
	before_validation :link_check, on: :create
	validates :message, presence: true
	validates :message, length: {maximum: 250, too_long: "Your tweet is too long."}, on: :create
	after_validation :apply_link, on: :create

# take full link and store it somewhere
# store in tweets table by adding column to tweets using migration rails g migration AddLinkToTweets link:string
# shorten link to 23 characters
# make link clickable

	def link_check
		if self.message.include? "https://"
			arr = self.message.split
			# find me the index where the curly bracket area is equal to true, and set that index equal to indx
			indx = arr.map { |x| x.include? "https://"}.index(true)
			# take what is in the array at index # and assign it as a link attribute to the curent instance of tweet (self) 
			self.link= arr[indx]

			# check and see if the item at array indx length is greater than 23? if so , we havfe to shorten it.
			if arr[indx].length > 23
				arr[indx]="#{arr[indx][0..20]}..."
			end

			self.message= arr.join(" ")
		end	
	end	

	def apply_link
			arr = self.message.split

			indx = arr.map { |x| x.include? "https://"}.index(true)
			if indx
			url = arr[indx]

			arr[indx] = "<a href='#{self.link}' target='_blank'>#{url}</a>"
			end
			self.message=arr.join(" ")
	end
end
