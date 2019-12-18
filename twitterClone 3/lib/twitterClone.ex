defmodule TwitterClone do
use Application
  def start do


    	:ets.new(:clientsregistry, [:set, :public, :named_table])
        :ets.new(:userTweets, [:set, :public, :named_table])
        :ets.new(:hashtagsTweets, [:set, :public, :named_table])
        :ets.new(:following, [:set, :public, :named_table])
        :ets.new(:followers, [:set, :public, :named_table])
        :ets.new(:mentions, [:set, :public, :named_table])
        
    
  end
end
TwitterClone.start