class EpicenterController < ApplicationController
  def feed
  	# initiate empty array
  	@following_tweets = []
  	# iterate through all tweets, find those that your'e following and push them into arrow
  	Tweet.all.each do |tweet|
  		if current_user.following.include?(tweet.user.id) || current_user.id == tweet.user.id
  			@following_tweets.push(tweet)
  		end
  	end
  end

  def show_user
  end

  def now_following
  end

  def unfollow
  end
end