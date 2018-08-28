class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
# make sure user is signed in before tweeting
  before_action :authenticate_user!

  include TweetsHelper
  # GET /tweets
  # GET /tweets.json
  def index
    @tweets = Tweet.all
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = Tweet.create(tweet_params)
    # need to associate to helper file - after before action
    @tweet = get_tagged(@tweet)
    # *********removing all this stuff and moving it to tweets helper file to keep 'fat model skinny controller'


    # # create temporary array that splits the message into a string temporarily

    # message_arr = @tweet.message.split

    # message_arr.each do |word, index|
    #   if word[0] == "#"
    #     # checking the phrase column of the tag table .pluck makes the phrases an array and include checks for that tag
    #     if Tag.pluck(:phrase).include?(word.downcase)
    #       # save that tag as a variable to use in TweetTag creation
    #       tag = Tag.find_by(phrase: word.downcase)
    #     else
    #       # create a new instance of Tag
    #       tag = Tag.create(phrase: word.downcase)
    #     end
    #     # create new instance of tweet_tag
    #     tweet_tag = TweetTag.create(tweet_id: @tweet.id, tag_id: tag.id)

    #     # replace the tweet with the link instance of itself
    #     # at this index of this word that I'm iterating over, set it equal to an anchor tag
    #     message_arr[index] = "<a href='/tag_tweets?id=#{tag.id}'>#{word}</a>"
    #   end
    # end

    # # put the split array back together. join with spaces. 
    # @tweet.update(message: message_arr.join(" "))

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:message, :user_id, :link)
    end
end
