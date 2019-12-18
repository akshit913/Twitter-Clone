defmodule TwitterCloneWeb.RoomChannel do
  use TwitterCloneWeb, :channel
  use Phoenix.Channel
  

  def join(_topic, _payload, socket) do
    IO.puts("f")
    {:ok, socket}
  end
  
  def handle_in("registerUser",%{"name" => username},socket) do
    IO.puts("gg");
    IO.puts(username);
    #:ets.insert(:clientRegistry, {username,socket.channel_pid})
    :ets.insert(:following,{username,[]})
    :ets.insert(:followers,{username,[]})
    :ets.insert(:mentions,{username,[]})
    :ets.insert(:userTweets,{username,[]})
    #push socket, "registerConfirmed", %{}
    {:noreply,socket}
  end


  def handle_in("follow", %{"userId" => currUser,"accountId" => username}, socket) do
      followingEle = :ets.lookup(:following, currUser)
      list = elem(List.keyfind(followingEle,currUser,0),1)
      :ets.insert(:following, {currUser,[username|list]})
      followerElement = :ets.lookup(:followers, username)
      secList = elem(List.keyfind(followerElement,username,0),1)
      :ets.delete(:followers,username)
      :ets.insert(:followers, {username,[currUser|secList]})
    {:noreply, socket}
  end

  def handle_in("tweet", %{"userId" => userId,"tweet" => tweetString}, socket) do
    IO.puts(tweetString)
    process_tweet(tweetString,userId)
    {:noreply, socket}
  end

  def handle_in("tweetsWithHashtag", %{"userId" => userId,"tag" => hashtag}, socket) do
    elemHt = :ets.lookup(:hashtagsTweets,hashtag)
    if(length(:ets.lookup(:hashtagsTweets,hashtag)) == 0) do
    push socket, "repTweetsWithHashtag", %{"userId" => userId, "list" => []}
    else
    htList =  elem(List.keyfind(elemHt,hashtag,0),1)
    push socket, "repTweetsWithHashtag", %{"userId" => userId, "list" => htList}
    end
    {:noreply, socket}
  end

  def handle_in("tweetsWithMention", %{"userId" => currUser}, socket) do
      elemMen = :ets.lookup(:mentions,currUser)
      if(length(:ets.lookup(:mentions,currUser)) == 0) do
      push socket, "repTweetsWithMention", %{"userId" => currUser, "list" => []}
      else
      menList =  elem(List.keyfind(elemMen,currUser,0),1)
      IO.inspect menList
      push socket, "repTweetsWithMention", %{"userId" => currUser, "list" => menList}
      end
      
      {:noreply, socket}
  end


  def process_tweet(tweet,currUser) do
      element = :ets.lookup(:userTweets, currUser)
      IO.inspect element
      if(length(:ets.lookup(:userTweets, currUser)) == 0) do
        :ets.insert(:userTweets, {currUser,[currUser <> ":" <> " " <>tweet]})
      else
        IO.puts "inside else"
        tweets = elem(List.keyfind(element,currUser,0),1)
        :ets.insert(:userTweets, {currUser,[currUser <> ":" <> " " <>tweet|tweets]})
      end
      wordList = String.split(tweet)
      hashtagList = Enum.filter(wordList, fn x -> String.starts_with?(x,"#") end)
      IO.inspect hashtagList
      IO.inspect wordList
      mentionList = Enum.filter(wordList, fn x -> String.starts_with?(x,"@") end)
      IO.inspect mentionList
      Enum.each(hashtagList,fn x ->
      if(length(:ets.lookup(:hashtagsTweets,x)) == 0) do
        :ets.insert(:hashtagsTweets,{x,tweet})
      else 
        elemHt = :ets.lookup(:hashtagsTweets,x)
        htList = elem(List.keyfind(elemHt,x,0),1)
        :ets.delete(:hashtagsTweets,x)
        :ets.insert(:hashtagsTweets, {x,[tweet|htList]})
      end
      end)

      Enum.each(mentionList,fn(x) ->
      if(length(:ets.lookup(:mentions,x)) == 0) do
        :ets.insert(:mentions,{x,tweet})
      else 
        elemMen = :ets.lookup(:mentions,x)
        menList = elem(List.keyfind(elemMen,x,0),1)
        :ets.delete(:mentions,x)
        :ets.insert(:mentions, {x,[tweet|menList]})
      end
      end)
      
  end

 


  
  

  

end