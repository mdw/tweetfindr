# findr.rb - another useless Twitter search app
%w(rubygems sinatra activerecord twitter_search haml).each { |r| require r }
%w( database helpers ).each { |lib| require "lib/#{lib}.rb" }

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
            t.integer :howmany
            t.timestamps
         end
      end
   rescue ActiveRecord::StatementInvalid
      # schema already exists
   end
end


class Search < ActiveRecord::Base
   validates_uniqueness_of :sstring
   attr_accessor :howmany

   def increment(id)
      #s = find(:id)
      #@count = s.howmany.to_i + 1
      #s.update_attribute(:howmany, @count)
   end
end


class Findr < Sinatra::Application
   
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
      @s = Search.find_by_sstring(params[:tag])
      if !@s.nil?
         @s.increment(@s.id)
      else
         search = Search.new(:sstring => t, :howmany => 1)
         if search.save
            status(201)
            @sysmessage = "(saved #{search.sstring} to the database)"
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
