# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
 
# pick up tasks from /lib/tasks/
Dir["#{File.dirname(__FILE__)}/lib/tasks/**/*.rake"].sort.each { |ext| load ext }

namespace :db do
   desc "Migrate the database"
   task(:migrate => :environment) do
      ActiveRecord::Base.logger = Logger.new(STDOUT)
      ActiveRecord::Migration.verbose = true
      ActiveRecord::Migrator.migrate("db/migrate")
   end
end
