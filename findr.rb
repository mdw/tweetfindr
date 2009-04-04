# findr.rb - another useless Twitter search app
%w(rubygems sinatra twitter_search haml).each { |r| require r }

configure do
   Debug = true
   SysMessage = ""
end

class Findr < Sinatra::Application
   
   get '/' do
	   haml :howto
   end

   get '/:tag', :agent => /Googlebot/ do
      halt 401, 'go away!'
   end

   get '/:tag' do |t|
      # add hash tag manually, since can't be passed in with URL
      @searchstr = t =~ /^@/ ? t : '#' + t
      @client = TwitterSearch::Client.new 'tweetfindr v0.2'
      @tweets = @client.query :q => @searchstr, :rpp => '25'
      ## @tweets.each { |t| puts t.source } if Debug
      headers 'Content-Type' => 'text/html; charset=utf-8'
	   haml :showtweets
   end
end
