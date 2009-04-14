# findr.rb - another useless Twitter search app
%w(rubygems sinatra activerecord twitter_search haml).each { |r| require r }
require "lib/helpers.rb" 


class Search < ActiveRecord::Base
   validates_uniqueness_of :sstring
   attr_accessor :howmany
end


class Findr < Sinatra::Application
   
   configure do
      @sysmessage = ""

      ActiveRecord::Base.establish_connection(
        :adapter => "mysql",
        :database => "tweetfindr_dev",
        :username => "tweetfinder",
        :password => "tf1ndr"
      )
      begin
         ActiveRecord::Schema.define do
            create_table :searches do |t|
               t.string :sstring
               t.integer :howmany, :default => 1
               t.timestamps
            end
         end
      rescue ActiveRecord::StatementInvalid
         # schema already exists
      end
   end


   helpers do
      include Helpers  # all my helpers defined in helpers.rb
      #
      # def link_to(url, title, klass, inner)
      # def termlink(hashtag)
      # def peoplelink(username)
      #
   end

   get '/' do
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

      # save search string to database
      sst = Search.find_by_sstring(t)
      if !sst.nil?
         sst.increment!(:howmany)
         @sysmessage = "<!-- found it #{sst.sstring}: #{sst.howmany} -->"
      else
         snew = Search.new(:sstring => t)
         if snew.save
            status(201)
            @sysmessage = "(saved #{snew.sstring} to the database)"
         else
            status(412)
            "Error: dup;licate search term, should have incremented counter\n"
         end
      end

      # get twitter search results
      @client = TwitterSearch::Client.new 'tweetfindr v0.2'
      @tweets = @client.query :q => @searchstr, :rpp => '25'
      headers 'Content-Type' => 'text/html; charset=utf-8'
      haml :showtweets
   end
end
