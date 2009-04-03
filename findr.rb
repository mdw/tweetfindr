# findr.rb - another useless Twitter search app
%w(rubygems sinatra twitter_search haml).each { |r| require r }

configure do
   SysMessage = ""
end

class Findr < Sinatra::Application
   
   get '*', :agent => /Googlebot\/2.1/ do
      @SysMessage = "Sorry my puny server can't handle lots of Googlebot requests"
      haml :howto
   end

   get '/' do
	   haml :howto
   end

   get '/:tag' do |t|
      # add hash tag manually, since can't be passed in with URL
      @searchstr = t =~ /^@/ ? t : '#' + t
      @client = TwitterSearch::Client.new 'tweetfindr v0.2'
      @tweets = @client.query :q => @searchstr, :rpp => '25'
      headers 'Content-Type' => 'text/html; charset=utf-8'
	   haml :showtweets
   end
end
