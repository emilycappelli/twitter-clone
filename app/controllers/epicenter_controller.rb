class EpicenterController < ApplicationController
  def following
    @user = User.find(params[:id])
    @users = []

    User.all.each do |user|
      if @user.following.include?(user.id)
        @users.push(user)
      end
    end
  end

  def followers
    @user = User.find(params[:id])
    @users = []

    User.all.each do |user|
      if user.following.include?(@user.id)
        @users.push(user)
      end
    end
  end

  
  # adding a method to see all users
  def all_users
    @users = User.all
  end

  def feed
  	# initiate empty array
  	@following_tweets = []
  	# iterate through all tweets, find those that your'e following and push them into arrow
  	if current_user
	  	Tweet.all.each do |tweet|
	  		if current_user.following.include?(tweet.user.id) || current_user.id == tweet.user.id
	  			@following_tweets.push(tweet)
	  		end
	  	end
  	end
  end

  def show_user
  	@user = User.find(params[:id])
  end

  def now_following
  	# add the user id of the user we want to follow to the following array (it's in the users table)
  	current_user.following.push(params[:id].to_i)
  	current_user.save

  	# we don't need a new view - just go back to that users page
  	redirect_to show_user_path(id: params[:id])
  end

  def unfollow
  	# remove the user id of the user we want to unfollow to the .following array)
  	current_user.following.delete(params[:id].to_i)
  	current_user.save

  	redirect_to show_user_path(id: params[:id])
  end

  def tag_tweets
	@tag = Tag.find(params[:id])
  end
end