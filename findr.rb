# findr.rb - another useless Twitter search app
%w(rubygems sinatra activerecord twitter_search haml).each { |r| require r }
%w( database helpers ).each { |lib| require "lib/#{lib}.rb" }


class Search < ActiveRecord::Base
   validates_uniqueness_of :sstring

   def self.find_top_ten
      find(:all, :order => "howmany DESC", :limit => 10)
   end

	def self.find_last_ten
		find(:all, :order => "id DESC", :limit => 10)
	end
end

class Icon < ActiveRecord::Base
	# time to try datamapper?
end


class Findr < Sinatra::Application
   
   configure do
      @sysmessage = ""
      Database.for_environment( environment )
   end

   helpers do
      include Helpers  # all my helpers defined in helpers.rb
      #
      # def link_to_home
      # def termlink(hashtag)
      # def peoplelink(username)
   end

   get '/' do
      @topten = Search.find_top_ten
      @lastten = Search.find_last_ten
      haml :howto
   end

   get '/:tag', :agent => /Googlebot|Slurp/ do
      halt 401, 'go away!'
   end

   get '/tweetfindr' do
      @sysmessage = 'tweetfindr is the sinatra-powered, twitter-searchin, totally useless toy'
      pass
   end
   
   get '/:tag/?' do |t|
      # add hash tag manually, since can't be passed in with URL
      @searchstr = t =~ /^@/ ? t : '#' + t

      # build array of twitter client icons from database
      icons = Icon.find(:all)
      @iconhash= {}
      icons.each {|i| @iconhash[i.client.downcase] = i.icon}

      # save search string to database
      sst = Search.find_by_sstring(t.downcase)
      if !sst.nil?
         sst.increment!(:howmany)
      else
         snew = Search.new(:sstring => t.downcase)
         if snew.save
            status(201)
            @sysmessage = "(saved #{snew.sstring} to the database)"
         else
            status(412)
            "Error: duplicate search term, should have incremented counter\n"
         end
      end

      # get twitter search results
      @client = TwitterSearch::Client.new 'tweetfindr v0.2'
      @tweets = @client.query :q => @searchstr, :rpp => '25'
     
        # should lookup icons here and tack onto array
        #@clienticon = Icon.find_by_client(clientname.downcase)
        #@sysmessage = @clienticon.icon if !@clienticon.nil?
        #tweet.icon = @clienticon.icon if !@clienticon.nil?
    
      headers 'Content-Type' => 'text/html; charset=utf-8'
      haml :showtweets
   end
end
