# findr.rb - another useless Twitter search app
%w(rubygems sinatra twitter_search haml).each { |r| require r }

configure do
   @debug = true
   @sysmessage = ""
end

helpers do
   def termlink(hashtag)
      url = "http://" + request.host + '/' + hashtag
      '<a href="' + url + '" class="hash" title="search for #' + hashtag + '">#' + hashtag + '</a>'
   end
   def peoplelink(username)
      url = "http://" + request.host + '/@' + username
      '<a href="' + url + '" class="people" title="search for @' + username + '">@' + username + '</a>'
   end
end

class Findr < Sinatra::Application
   
   get '/' do
	   haml :howto
   end

   get '/:tag', :agent => /Googlebot/ do
      halt 401, 'go away!'
   end

   get '/tweetfindr' do
      @sysmessage = 'yeah baby'
      pass
   end
   
   get '/:tag' do |t|
      # add hash tag manually, since can't be passed in with URL
      @searchstr = t =~ /^@/ ? t : '#' + t
      @client = TwitterSearch::Client.new 'tweetfindr v0.2'
      @tweets = @client.query :q => @searchstr, :rpp => '25'
      #@tweets.each { |t| puts t.source } if @debug
      headers 'Content-Type' => 'text/html; charset=utf-8'
	   haml :showtweets
   end
end
