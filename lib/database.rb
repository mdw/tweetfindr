# database.rb - wrapper around ActiveRecord
# helps with getting config from database.yml and running migrations

require 'activerecord'

class Database
  
  @@current_database = nil
  @@migration_path = File.join( File.dirname(__FILE__), "../db/migrations" )

  @@configuration_file = File.join( File.dirname(__FILE__), "../config/database.yml" )
  raise Exception.new("No '#{@@configuration_file}' file was found. ") if @@configuration_file.nil?
  @@configuration = YAML.load( File.open( @@configuration_file ) )
  
  
  def self.for_environment( environment, reload = false )
    @@current_database = nil if reload
    current_or_connect_to_database_for_environment( environment )
  end
  
  def self.migrate( environment )
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate( for_environment( environment ), @@migration_path )
  end
  
  def self.reset( environment )
    db = current_or_connect_to_database_for_environment( environment )
    db.tables.each do |table|
      db.drop_table table
    end
    migrate( environment )
  end
  
  private
  
  def self.current_or_connect_to_database_for_environment( environment )
    @@current_database ||= connect_to_database_for_environment( environment )
  end
  
  def self.connect_to_database_for_environment( environment )
    config = @@configuration[environment.to_s]
    unless config.nil?
      adapter = config['adapter']
      database = config['database']
      username = config['username']
      password = config['password']
      host = config['host']
      ActiveRecord::Base.establish_connection(
        :adapter => adapter, :database => database, :username => username, :password => password)
      puts "connected to #{database} database in #{environment} environment"
    else
      raise Exception.new("No database found for '#{environment}' environment. Please add to #{@@configuration_file}")
    end
  end
  
end

