require 'ActiveRecord'

namespace :db do
  @environment = nil

  desc "migrate DB"
  task :migrate => :environment do
    ActiveRecord::Base.establish_connection( 
     :adapter => 'mysql', 
     :database => 'tweetfindr_dev',
     :username => 'tweetfinder',
     :password => 'tf1ndr')
    ActiveRecord::Base.logger = Logger.new( STDOUT )
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate( "db/migrate" )
  end

  task :environment do
    @environment = ENV["RACK_ENV"] || :development
  end
end

task :default do
  # just run tests, nothing fancy
  Dir["test/**/*.rb"].sort.each { |test|  load test }
end
