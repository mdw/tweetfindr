# findr.rb - another useless Twitter search app
%w(rubygems sinatra twitter_search haml).each { |r| require r }

configure do
end

class Findr < Sinatra::Application
   get '/' do
	   haml :howto
   end

   get '/:tag' do |t|
	   headers 'Content-Type' => 'text/html; charset=utf-8'
      @client = TwitterSearch::Client.new 'tweetfindr v0.2'

      # add hash tag manually, since can't be passed in with URL
      @searchstr = t =~ /^@/ ? t : '#' + t
      @tweets = @client.query :q => @searchstr, :rpp => '25'
      @tweets.each { |t| puts t.text }
	   haml :showtweets
   end
end
