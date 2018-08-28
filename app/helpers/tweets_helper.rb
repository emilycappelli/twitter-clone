module TweetsHelper
	def get_tagged(tweet)
    # create temporary array that splits the message into a string temporarily

    message_arr = @tweet.message.split

    message_arr.each_with_index do |word, index|
      if word[0] == "#"
        # checking the phrase column of the tag table .pluck makes the phrases an array and include checks for that tag
        if Tag.pluck(:phrase).include?(word.downcase)
          # save that tag as a variable to use in TweetTag creation
          tag = Tag.find_by(phrase: word.downcase)
        else
          # create a new instance of Tag
          tag = Tag.create(phrase: word.downcase)
        end
        # create new instance of tweet_tag
        tweet_tag = TweetTag.create(tweet_id: @tweet.id, tag_id: tag.id)

        # replace the tweet with the link instance of itself
        # at this index of this word that I'm iterating over, set it equal to an anchor tag
        message_arr[index] = "<a href='/tag_tweets?id=#{tag.id}'>#{word}</a>"
      end
    end

    # put the split array back together. join with spaces. 
    @tweet.update(message: message_arr.join(" "))
    return tweet
end

end